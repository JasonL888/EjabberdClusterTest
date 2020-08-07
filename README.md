# EjabberdClusterTest
Test out ejabberd clustering


[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <h3 align="center">Local Ejabberd Cluster Test Environment</h3>
  <p align="center">
    For training, self-learning or experimenting
  </p>
</p>



<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
  * [Built With](#built-with)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
* [Usage](#usage)
* [License](#license)
* [Acknowledgements](#acknowledgements)



<!-- ABOUT THE PROJECT -->
## About The Project

Creates a local ejabberd/XMPP cluster environment for training, self-learning or simply experimenting.

Typically, you need at least 2 nodes to form a ejabberd cluster and can a bit of a hassle to provision physical servers or even cloud-based ones. With this, you can create local environment using Docker containers in your local desktop. Easier to troubleshoot or experiement


### Built With
* [Docker](https://www.docker.com)
* [Ejabberd](https://docs.ejabberd.im/)
* [SleekXMPP](https://sleekxmpp.readthedocs.io/en/latest/)
* [Bash](https://www.gnu.org/software/bash/)


<!-- GETTING STARTED -->
## Getting Started
To get a local copy up and running follow these simple example steps.

### Prerequisites
You will need the following software on your local desktop (macOS for my case)
* Docker for Desktop
 * Install from https://docs.docker.com/docker-for-mac/install/
* Python 3

### Installation

1. Clone the repo
```sh
git clone git@github.com:JasonL888/EjabberdClusterTest.git
```
1. Create python virtual environment
```sh
cd EjabberdClusterTest
python3 -m venv venv
```
1. Install sleekxmpp in your virtual environment
```sh
source ./venv/bin/activate
pip install sleekxmpp
```



<!-- USAGE EXAMPLES -->
## Usage

1. Ensure Docker for Desktop is running
* On mac, upper right, look for "whale" icon
  * confirm "Docker Desktop is running"
2. Navigate to directory where you did above git clone
```sh
cd EjabberdClusterTest
```
3. Start up containers (in directory with `docker-compose.yml`)
```sh
docker-compose up
```
> Leave the Terminal running so you can view the ejabberd messages live
>
> Docker commands starts up the containers `ejabberd01` and `ejabberd02`
> * In docker compose,
>  * map `ejabberd01` port 5222 is mapped to localhost:5122
>  * map `ejabberd02` port 5222 is mapped to localhost:5222

4. Set-up the cluster
```sh
./cluster_setup.sh
```
> Bash script
> * runs docker commands to execute within container `ejabberd02` to join `ejabberd01` in cluster
> * runs docker commands to register users on one container and check from the other container (to show clustering replicates user registrations to peer node)

5. Connect two XMPP clients and send messages back-forth
* Start up first XMPP echo client
 * Open first terminal and access git clone directory
```sh
cd EjabberdClusterTest
source ./venv/bin/activate
python SleekXMPP_Example/echo_client.py -d -j user01@mycluster.com -c password -H localhost -p 5122
```
> Leave the Terminal running so you can view the XMPP messages
>
> this connects localhost:5122 which maps to `ejabberd01` port 5222

* Start up second XMPP echo client
 * Open second terminal and access git clone directory
 ```sh
 cd EjabberdClusterTest
 source ./venv/bin/activate
 python SleekXMPP_Example/echo_client.py -d -j user02@mycluster.com -c password -H localhost -p 5222
 ```
 > Leave the Terminal running so you can view the XMPP messages
 >
 > this connects localhost:5222 which maps to `ejabberd02` port 5222

* Trigger the ping-pong between the two echo XMPP clients
 * Open third terminal to send message from user01@mycluster.com to user02@mycluster.com
 ```sh
 docker exec -it ejabberd01 bin/ejabberdctl send_message chat user01@mycluster.com user02@mycluster.com "long title ..." "long body ..."
 ```
 > this sends a XMPP chat message from user01 to user02
 > since the clients are echo clients, it will trigger infinite reply loop
 >
 > note: user01 was connected to `ejabberd01` while user02 is connected to `ejabberd02`

6. Shutdown
* `<ctrl>-C` on all the XMPP terminals
* shutdown the containers (in folder with `docker-compose.yml`)
```sh
docker-compose down
```
* to exit the python virtual environment
```sh
deactivate
```

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.


<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [Docker](https://www.docker.com)
* [Ejabberd](https://docs.ejabberd.im/)
* [SleekXMPP](https://sleekxmpp.readthedocs.io/en/latest/)




<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/othneildrew/Best-README-Template.svg?style=flat-square
[contributors-url]: https://github.com/othneildrew/Best-README-Template/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/othneildrew/Best-README-Template.svg?style=flat-square
[forks-url]: https://github.com/othneildrew/Best-README-Template/network/members
[stars-shield]: https://img.shields.io/github/stars/othneildrew/Best-README-Template.svg?style=flat-square
[stars-url]: https://github.com/othneildrew/Best-README-Template/stargazers
[issues-shield]: https://img.shields.io/github/issues/othneildrew/Best-README-Template.svg?style=flat-square
[issues-url]: https://github.com/othneildrew/Best-README-Template/issues
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=flat-square
[license-url]: https://github.com/othneildrew/Best-README-Template/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/othneildrew
[product-screenshot]: images/screenshot.png
