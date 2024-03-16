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
    ````
2. Forward port 80 locally, so that it answers calls through a browser (or curl or wget).
3. See the logs of the running container.
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
