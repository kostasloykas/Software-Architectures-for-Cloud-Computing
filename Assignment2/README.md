# Assignment 2
# Name: Konstantinos Loukas
# AM: csdp1375
<details>
<summary>Exercise 1</summary>


1. Install the manifest on Kubernetes and start the Pod.
    ```
    >kubectl apply -f Ex1.yaml
    pod/mypod created

    >kubectl get pods
    NAME    READY   STATUS    RESTARTS   AGE
    mypod   1/1     Running   0          17s
    ```
2. Forward port 80 locally, so that it answers calls through a browser (or curl or wget).

    ```
    >kubectl apply -f Ex1.yaml

    >kubectl port-forward pod/mypod 8080:80
    Forwarding from 127.0.0.1:8080 -> 80
    Forwarding from [::1]:8080 -> 80
    Handling connection for 8080

    ````

3. See the logs of the running container.
    ```
    >kubectl logs mypod
    /docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
    /docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
    /docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
    10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
    10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
    /docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
    /docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
    /docker-entrypoint.sh: Configuration complete; ready for start up
    2024/03/16 07:08:43 [notice] 1#1: using the "epoll" event method
    2024/03/16 07:08:43 [notice] 1#1: nginx/1.23.3
    2024/03/16 07:08:43 [notice] 1#1: built by gcc 12.2.1 20220924 (Alpine 12.2.1_git20220924-r4) 
    2024/03/16 07:08:43 [notice] 1#1: OS: Linux 5.15.0-97-generic
    2024/03/16 07:08:43 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
    2024/03/16 07:08:43 [notice] 1#1: start worker processes
    2024/03/16 07:08:43 [notice] 1#1: start worker process 30
    2024/03/16 07:08:43 [notice] 1#1: start worker process 31
    2024/03/16 07:08:43 [notice] 1#1: start worker process 32
    2024/03/16 07:08:43 [notice] 1#1: start worker process 33
    2024/03/16 07:08:43 [notice] 1#1: start worker process 34
    2024/03/16 07:08:43 [notice] 1#1: start worker process 35
    127.0.0.1 - - [16/Mar/2024:07:12:42 +0000] "GET / HTTP/1.1" 200 615 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36" "-"
    127.0.0.1 - - [16/Mar/2024:07:12:42 +0000] "GET /favicon.ico HTTP/1.1" 404 555 "http://localhost:8080/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36" "-"
    2024/03/16 07:12:42 [error] 32#32: *1 open() "/usr/share/nginx/html/favicon.ico" failed (2: No such file or directory), client: 127.0.0.1, server: localhost, request: "GET /favicon.ico HTTP/1.1", host: "localhost:8080", referrer: "http://localhost:8080/"
    ```

4. Open a shell session inside the running container and change the first sentence of the default page to "Welcome to MY nginx!". Close the session.
5. From your computer terminal (outside the container), download the default page locally and upload another one in its place.
6. Stop the Pod and remove the manifest from Kubernetes.

</details>

<details>
<summary>Exercise 2</summary>
</details>

<details>
<summary>Exercise 3</summary>
</details>

<details>
<summary>Exercise 4</summary>
</details>
