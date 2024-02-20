# hy548
<details>
<summary>Excersice 1</summary>

1. Download the images tagged 1.23.3 and 1.23.3-alpine locally.

>Docker image pull  nginx:1.23.3
>Docker image pull  nginx:1.23.3-alpine

2. Compare the sizes of the two images.

REPOSITORY                TAG             IMAGE ID       CREATED         SIZE
hello-world               latest        	  9c7a54a9a43c   9 months ago    13.3kB
nginx                     	1.23.3         	 ac232364af84   11 months ago   142MB
nginx                     	1.23.3-alpine   	2bc7edbc3cf2   12 months ago   40.7MB

Παρατηρούμε ότι το image nginx-alpine έχει σημαντικά μικρότερο μέγεθος σε σύγκριση με το image nginx. Αυτό οφείλεται στο γεγονός ότι το image nginx-alpine βασίζεται στο Alpine Linux, το οποίο είναι γνωστό για την ελαφρότητά του καθώς περιλαμβάνει μόνο τα απολύτως απαραίτητα για την εκτέλεση της εφαρμογής.

c. Start one of the two images in the background, with the appropriate network
settings to forward port 80 locally and use a browser (or curl or wget) to see that
calls are answered. What is the answer?

> docker run -p 8080:80 -d nginx:1.23.3-alpine
> curl http://127.0.0.1:8080

</details>
