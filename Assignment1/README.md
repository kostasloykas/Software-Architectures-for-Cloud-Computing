# hy548
<details>
<summary>Exercise 1</summary>

1. Download the images tagged 1.23.3 and 1.23.3-alpine locally.

    ```
    >Docker image pull  nginx:1.23.3
    >Docker image pull  nginx:1.23.3-alpine
    ```

2. Compare the sizes of the two images.
    ```
    REPOSITORY                TAG             IMAGE ID       CREATED         SIZE
    hello-world               latest        	  9c7a54a9a43c   9 months ago    13.3kB
    nginx                     	1.23.3         	 ac232364af84   11 months ago   142MB
    nginx                     	1.23.3-alpine   	2bc7edbc3cf2   12 months ago   40.7MB
    ```

    Παρατηρούμε ότι το image nginx-alpine έχει σημαντικά μικρότερο μέγεθος σε σύγκριση με το image nginx. Αυτό οφείλεται στο γεγονός ότι το image nginx-alpine βασίζεται στο Alpine Linux, το οποίο είναι γνωστό για την ελαφρότητά του καθώς περιλαμβάνει μόνο τα απολύτως απαραίτητα για την εκτέλεση της εφαρμογής.

3. Start one of the two images in the background, with the appropriate network settings to forward port 80 locally and use a browser (or curl or wget) to see that calls are answered. What is the answer?

    ```
    > docker run -p 8080:80 -d nginx:1.23.3-alpine
    > curl http://127.0.0.1:8080
    ```


    Answer:

    ```
    <!DOCTYPE html>
    <html>
    <head>
    <title>Welcome to nginx!</title>
    <style>
    html { color-scheme: light dark; }
    body { width: 35em; margin: 0 auto;
    font-family: Tahoma, Verdana, Arial, sans-serif; }
    </style>
    </head>
    <body>
    <h1>Welcome to nginx!</h1>
    <p>If you see this page, the nginx web server is successfully installed and
    working. Further configuration is required.</p>

    <p>For online documentation and support please refer to
    <a href="http://nginx.org/">nginx.org</a>.<br/>
    Commercial support is available at
    <a href="http://nginx.com/">nginx.com</a>.</p>

    <p><em>Thank you for using nginx.</em></p>
    </body>
    </html>
    ```

4. Confirm that the container is running in Docker.

    ```
    > docker ps

    CONTAINER ID   IMAGE                 COMMAND                  CREATED         STATUS         
    9d34b2a3aa44   nginx:1.23.3-alpine   "/docker-entrypoint.…"   5 seconds ago   Up 3 seconds   

    PORTS                                   			NAMES
    0.0.0.0:8080->80/tcp, :::8080->80/tcp   ecstatic_roentgen
    ```

5. Get the logs of the running container.

    ```
    >docker logs ecstatic_roentgen 

    /docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
    /docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
    /docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
    10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
    10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
    /docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
    /docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
    /docker-entrypoint.sh: Configuration complete; ready for start up
    2024/02/18 18:15:36 [notice] 1#1: using the "epoll" event method
    2024/02/18 18:15:36 [notice] 1#1: nginx/1.23.3
    2024/02/18 18:15:36 [notice] 1#1: built by gcc 12.2.1 20220924 (Alpine 12.2.1_git20220924-r4) 
    2024/02/18 18:15:36 [notice] 1#1: OS: Linux 5.15.0-92-generic
    2024/02/18 18:15:36 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
    2024/02/18 18:15:36 [notice] 1#1: start worker processes
    2024/02/18 18:15:36 [notice] 1#1: start worker process 29
    2024/02/18 18:15:36 [notice] 1#1: start worker process 30
    2024/02/18 18:15:36 [notice] 1#1: start worker process 31
    2024/02/18 18:15:36 [notice] 1#1: start worker process 32
    2024/02/18 18:15:36 [notice] 1#1: start worker process 33
    2024/02/18 18:15:36 [notice] 1#1: start worker process 34

    ```

6. Stop the running container.

    ```
    >docker stop ecstatic_roentgen
    >docker ps

    CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
    …...
    ```

7. Start the stopped container.

    ```
    >docker start ecstatic_roentgen 
    >docker ps

    CONTAINER ID   IMAGE                 COMMAND                  CREATED         STATUS          
    9d34b2a3aa44   nginx:1.23.3-alpine   "/docker-entrypoint.…"   7 minutes ago   Up 38 seconds   

    PORTS                                   			NAMES
    0.0.0.0:8080->80/tcp, :::8080->80/tcp   ecstatic_roentgen
    ```
8. Stop the container and remove it from Docker.

    ```
    >docker stop ecstatic_roentgen
    >docker rm ecstatic_roentgen
    >docker ps -a
    
    CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
    ……..
    ```
</details>




<details>

<summary>Exercise 2</summary>

1. Open a shell session inside the running container and change the first sentence of the default page to "Welcome to MY nginx!". Close the session.


    ```
    >docker run -p 8080:80 -d nginx:1.23.3
    >docker ps
    
    CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS PORTS                                   NAMES
    d56eaf24fba3   nginx:1.23.3   "/docker-entrypoint.…"   6 seconds ago   Up 5 seconds   0.0.0.0:8080->80/tcp, :::8080->80/tcp   quirky_mcnulty

    ```

    Εκτελούμε την εντολή αυτή για να ξεκινήσουμε το shell μέσα στο container

    ```
    >docker exec -it quirky_mcnulty /bin/bash
    ```
    
    Αφού μπούμε στο container, πηγαίνουμε στον φάκελο `/usr/share/nginx/html` για να επεξεργαστούμε το αρχείο `index.html` και κάνουμε τις κατάλληλες τροποποιήσεις. Αλλά επειδή δεν έχουμε κάποιον επεξεργαστή κειμένου, θα εγκαταστήσουμε το nano με τις εξής εντολές:

    ```
    >apt-get update
    >apt install nano
    ```

    και έπειτα επεξεργαζόμαστε το αρχείο.

2. From your computer's terminal (outside the container) download the default page locally and upload another one in its place.

    Κάνουμε download απο το τερματικό με την εξής εντολή:

    ```
    >docker cp quirky_mcnulty:/usr/share/nginx/html/index.html index.html
    
    ```
    Θα επεξεργαστούμε το αρχείο και θα το ξαναβάλουμε μέσα στο container.

    ```
    >docker cp index.html quirky_mcnulty:/usr/share/nginx/html/index.html
    ```


3. Close the container, delete it and start another instance. Do you see the changes? Why;

    ```
    >docker stop quirky_mcnulty
    >docker rm quirky_mcnulty
    >docker run -p 8080:80 -d nginx:1.23.3
    ```

    Παρατηρούμε ότι οι αλλαγές που κάναμε στο προηγούμενο ερώτημα δεν εμφανίζονται στο νέο container. Αυτό οφείλεται στο γεγονός ότι το image που χρησιμοποιούμε για τη δημιουργία του container δεν περιλαμβάνει τις τροποποιήσεις που πραγματοποιήσαμε πριν.

</details>




<details>

<summary>Exercise 3</summary>

1. Write down the commands needed to download the repository (and submodules) and hugo (the tool that builds the website), build the website locally, and start an Nginx container to serve the CS-548 website instead of the default page.

    Κανουμε clone απο το repo στο git με την παραμετρο recursive για να κανει include και τα submodules.
    
    ```
    > git clone –recursive https://github.com/chazapis/hy548
    >sudo apt install hugo
    >cd hy548
    > make html 

    (cd html && hugo -D)
    Start building sites … 
    hugo v0.92.2+extended linux/amd64 BuildDate=2023-01-31T11:11:57Z VendorInfo=ubuntu:0.92.2-1ubuntu0.1

                    | EL | EN  
    -------------------+----+-----
    Pages            |  3 |  3  
    Paginator pages  |  0 |  0  
    Non-page files   |  0 |  0  
    Static files     | 60 | 60  
    Processed images |  0 |  0  
    Aliases          |  1 |  0  
    Sitemaps         |  0 |  0  
    Cleaned          |  0 |  0  

    Total in 83 ms
    ```


    Βλεπουμε οτι εγινε build η εφαρμογη και δημιουργηθηκε ο φακελος public.

    Τωρα θα τρεξουμε ξανα ενα nginx container και θα βαλουμε την σελιδα του μαθηματος μεσα το container ωστε να την τρεξει. 

    Επειδη εφτιαξα αλλο nginx container αλλαξε και το ονομα του.

    ```
    >cd hy548/html/public
    >docker cp . great_torvalds:/usr/share/nginx/html
    >docker restart great_torvalds
    ```


    και βλεπουμε οτι τρεχει κανονικα αφου καναμε restart το container.



</details>




<details>

<summary>Exercise 4</summary>



1. The Dockerfile.

    ```
    FROM nginx:1.23.3

    RUN apt-get update && \
    apt install -y git && \
    apt install -y hugo && \
    git clone --recursive https://github.com/chazapis/hy548 && \
    cd hy548/html && \
    hugo -D && \
    cp -r public/* /usr/share/nginx/html/
    ```



2. The command needed to upload the image to Docker Hub.
    
    ```
    >docker login
    >docker tag image_assignment1:latest kostasloykas/assingment1
    >docker push kostasloykas/assignment1
    ```





3. How much bigger is your own image than the image you were based on. Why;

    ```
    >docker ps -s

    CONTAINER ID   IMAGE                      COMMAND                  CREATED          STATUS          PORTS                                   NAMES             SIZE

    9d54d3f6b1c8   image_assignment1:latest   "/docker-entrypoint.…"   39 seconds ago   Up 38 
    seconds   80/tcp                                  elastic_burnell   1.09kB (virtual 324MB)

    6997303345ac   nginx:1.23.3               "/docker-entrypoint.…"   29 hours ago     Up 12 minutes   0.0.0.0:8080->80/tcp, :::8080->80/tcp   great_torvalds    6.74MB (virtual 149MB)
    ```

    Όπως βλέπουμε, το image που δημιουργήσαμε από το Dockerfile είναι πολύ μεγαλύτερη από το image που είχαμε δημιουργήσει πριν (για την ακρίβεια, 175MB μεγαλύτερη). Αυτό οφείλεται στο ότι εγκαταστήσαμε κάποιες βιβλιοθήκες, ενημερώσαμε το apt repository μέσα στο image, και επίσης, κλωνοποιήσαμε τη σελίδα από το GitHub. Οπότε είναι λογικό να έχει και μεγαλύτερο μέγεθος από το προηγούμενο image όπου το build του ιστότοπου έγινε έξω από το image."

4. What have you done in the Dockerfile to keep the image as small as possible?

    Συνδύασα πολλές εντολές RUN σε ένα μόνο επίπεδο για να ελαχιστοποιήσω τον αριθμό των επιπέδων στο image. Αυτό μειώνει το συνολικό μέγεθος.



</details>

