# Assignment 3
# Name: Konstantinos Loukas
# AM: csdp1375

<details>
<summary>Exercise 1</summary>


1. Instead of "Hello from Python Flask!", the flask-hello container will return the value of the MESSAGE environment variable when someone uses the service (use Python's os.getenv). Provide the new Dockerfile and hello.py. Build and upload the new container to Docker Hub.

    Dockerfile:
    ```
    FROM python:3.10.3-slim

    RUN pip install Flask

    COPY . /app
    WORKDIR /app
    ENV MESSAGE="Hello from csdp1375"

    CMD python hello.py
    ```

    Hello.py:
    ```
    import os
    from flask import Flask

    app = Flask(__name__)

    @app.route('/')
    def index():
        return os.getenv("MESSAGE")

    app.run(host='0.0.0.0', port=8080)
    ```

    Upload the image to Docker Hub.
    ```
    >docker tag flask:latest kostasloykas/assingment2:latest
    >docker push kostasloykas/assignment2
    ```

2. Provide two YAMLs to deploy the above container with all necessary resources (Deployment, Service, Ingress), so that "This is the first service!" is returned when someone visits the /first endpoint, and "This is the second service!" when someone visits the /second.

    first.yaml:
    ```
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
    name: flask-one-ingress
    annotations:
        nginx.ingress.kubernetes.io/rewrite-target: /
    spec:
    rules:
    - http:
        paths:
        - path: /first
            pathType: Prefix
            backend:
            service:
                name: flaskone
                port:
                number: 8080


    ---
    apiVersion: v1
    kind: Service
    metadata:
    name: flaskone
    spec:
    type: ClusterIP
    ports:
    - port: 8080
    selector:
        app: flaskone


    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
    name: flaskone
    spec:
    replicas: 1
    selector:
        matchLabels:
        app: flaskone
    template:
        metadata:
        labels:
            app: flaskone
        spec:
        containers:
            - name: flaskone
            image: kostasloykas/assignment2:latest
            env:
                - name: MESSAGE
                value: "This is the first service!"

    ```

    second.yaml:
    ```
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
    name: flask-two-ingress
    annotations:
        nginx.ingress.kubernetes.io/rewrite-target: /
    spec:
    rules:
    - http:
        paths:
        - path: /second
            pathType: Prefix
            backend:
            service:
                name: flasktwo
                port:
                number: 8080


    ---
    apiVersion: v1
    kind: Service
    metadata:
    name: flasktwo
    spec:
    type: ClusterIP
    ports:
    - port: 8080
    selector:
        app: flasktwo


    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
    name: flasktwo
    spec:
    replicas: 1
    selector:
        matchLabels:
        app: flasktwo
    template:
        metadata:
        labels:
            app: flasktwo
        spec:
        containers:
            - name: flasktwo
            image: kostasloykas/assignment2:latest
            env:
                - name: MESSAGE
                value: "This is the second service!"

    ```

3. Provide the commands needed to test the above two services with minikube (from running minikube, to curl or wget commands to use the services). Assume that the first deployment is in first.yaml and the second in second.yaml.

    The commands for testing the above two services are:
    ```
    minikube start
    minikube addons enable ingress
    minikube addons enable metrics-server
    kubectl apply -f locust.yaml
    kubectl apply -f first.yaml
    kubectl apply -f second.yaml
    minikube tunnel
    ```
    Afterward, when I requested the URL 192.168.49.2/first, it displayed the appropriate message. Similarly, when I accessed the URL 192.168.49.2/second, it also showed the corresponding message, as depicted in the pictures below.

    First service:
    ![Local Image](./images/1.png)

    Second service:
    ![Local Image](./images/2.png)


</details>

<details>
<summary>Exercise 2</summary>

I modified the locust.yaml file to direct requests to the root endpoint (/) instead of '/hello'.

1. Following on from the previous exercise, extend the YAML that implements the /first endpoint: To limit each Pod to a maximum of 20% CPU and 256MB RAM. With a HorizontalPodAutoscaler manifest, which will increase the number of Pods in the Deployment when the average CPU usage exceeds 80%. Set a minimum of 1 Pod and a maximum of 8 for the Deployment.


    first.yaml

    ```
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
    name: flask-one-ingress
    annotations:
        nginx.ingress.kubernetes.io/rewrite-target: /
    spec:
    rules:
    - http:
        paths:
        - path: /first
            pathType: Prefix
            backend:
            service:
                name: flaskone
                port:
                number: 8080


    ---
    apiVersion: v1
    kind: Service
    metadata:
    name: flaskone
    spec:
    type: ClusterIP
    ports:
    - port: 8080
    selector:
        app: flaskone


    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
    name: flaskone
    spec:
    replicas: 1
    selector:
        matchLabels:
        app: flaskone
    template:
        metadata:
        labels:
            app: flaskone
        spec:
        containers:
            - name: flaskone
            image: kostasloykas/assignment2:latest
            resources:
                limits:
                cpu: "200m"
                memory: "256Mi"
            env:
                - name: MESSAGE
                value: "This is the first service!"


    ---
    apiVersion: autoscaling/v2
    kind: HorizontalPodAutoscaler
    metadata:
    name: flaskone-autoscaler
    spec:
    scaleTargetRef:
        apiVersion: apps/v1
        kind: Deployment
        name: flaskone
    minReplicas: 1
    maxReplicas: 8
    metrics:
    - type: Resource
        resource:
        name: cpu
        target:
            type: Utilization
            averageUtilization: 80

    ```

    second.yaml
    
    ```
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
    name: flask-two-ingress
    annotations:
        nginx.ingress.kubernetes.io/rewrite-target: /
    spec:
    rules:
    - http:
        paths:
        - path: /second
            pathType: Prefix
            backend:
            service:
                name: flasktwo
                port:
                number: 8080


    ---
    apiVersion: v1
    kind: Service
    metadata:
    name: flasktwo
    spec:
    type: ClusterIP
    ports:
    - port: 8080
    selector:
        app: flasktwo


    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
    name: flasktwo
    spec:
    replicas: 1
    selector:
        matchLabels:
        app: flasktwo
    template:
        metadata:
        labels:
            app: flasktwo
        spec:
        containers:
            - name: flasktwo
            image: kostasloykas/assignment2:latest
            env:
                - name: MESSAGE
                value: "This is the second service!"

    ```

    The benchmarking tool used is Locust, which is provided within the scaling repository. 

    ![Local Image](./images/3.png)
    ![Local Image](./images/4.png)


    For the first.yaml the output of the command line utitility is displayed below. It required a total of 8 pods to handle the requests from 100 users, as observed with 0% failures.
    
    
    ```
    >kubectl get hpa flaskone-autoscaler --watch

    NAME                  REFERENCE             TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
    flaskone-autoscaler   Deployment/flaskone   <unknown>/80%   1         8         1          43s
    flaskone-autoscaler   Deployment/flaskone   <unknown>/80%   1         8         1          55s
    flaskone-autoscaler   Deployment/flaskone   99%/80%         1         8         1          115s
    flaskone-autoscaler   Deployment/flaskone   99%/80%         1         8         4          2m10s
    flaskone-autoscaler   Deployment/flaskone   100%/80%        1         8         4          2m56s
    flaskone-autoscaler   Deployment/flaskone   98%/80%         1         8         4          3m56s
    flaskone-autoscaler   Deployment/flaskone   98%/80%         1         8         5          4m11s
    flaskone-autoscaler   Deployment/flaskone   98%/80%         1         8         5          4m56s
    flaskone-autoscaler   Deployment/flaskone   98%/80%         1         8         5          5m56s
    flaskone-autoscaler   Deployment/flaskone   98%/80%         1         8         7          6m11s
    flaskone-autoscaler   Deployment/flaskone   95%/80%         1         8         7          6m56s
    flaskone-autoscaler   Deployment/flaskone   90%/80%         1         8         7          7m56s
    flaskone-autoscaler   Deployment/flaskone   90%/80%         1         8         8          8m11s
    flaskone-autoscaler   Deployment/flaskone   80%/80%         1         8         8          8m56s
    ```


    As we can see for the second.yaml the unique pod had 17% failures. 
    ![Local Image](./images/5.png)
    ![Local Image](./images/6.png)


</details>


<details>
<summary>Exercise 3</summary>




</details>
