![Doubtfire Logo](http://puu.sh/lyClF/fde5bfbbe7.png)
# Dream Big

Dream big aims to provide students with an overview of their progress from enrolment to graduation. The idea is to create a work-ready student who can assimilate into the workplace.

Click here to view the [Mac Installation instructions](#mac-installation-instruction)

Click here to view the [Windows Installation instructions](#windows-11-installation-instructions)

***

## **Mac Installation Instruction**

What we cover in this Mac Installation Instruction:

- [x] Node.Js 16.16.0
- [x] Angular
- [x] Docker

Installation steps:

1. Download and install node.js 16.16.0 by [here][mac-1].

2. After installing node.js, type in `node –version` in your terminal to check your node.js version and make sure it is installed properly.

3. Open the terminal and type in `sudo npm install -g @angular/cli` to install angular.

4. Wait a few seconds and type in `ng version` to check the angular version and make sure it is installed properly.

5. Clone the directory from GitHub using the GitHub desktop app.

6. Navigate to your terminal until you reach dream-big-ui.

7. Type in `ng serve` in your terminal after and you will see some messages show up one of which is `Angular Live Development Server is listening on localhost:4200, open your browser on http://localhost:4200/ **`

8. Go to your preferred browser and type in `http://localhost:4200/`

9. You can now see how the project looks in its current state.

10. You can open the code using visual studio code by typing in code. after navigating to dream-big-ui

11. Install the docker app for mac depending on which mac you are using ( intel mac or mac with apple chip) [here][mac-2].

12. Open a terminal window and navigate to the DreamBig project, enter and run the following line `docker compose up`.

13. You can now go to the Docker app and run the dream big container.

***

## **Windows 11 Installation instructions**

What we cover in this Windows Installation Instruction

- [x] Chocolatey (Recommended)
- [x] Node.Js 16.16.0
- [x] Angular
- [x] Git
- [x] Docker
- [x] Windows Subsystem for Linux

Installation steps:

- Install chocolatey (Highly Recommended)
    
    It is optional to install the chocolatey package manager but highly recommended since it is very useful for installing various software packages such as Python and Node.Js(Which we will be Chocolatey to install) on Windows systems. 
    
    To install Chocolatey, [click here][win-1] and follow the instructions. 
    
- Install Node.Js

    If you have Chocolatey installed, type in the following command: `choco install nodejs --version=16.16.0` in PowerShell with administrator mode and then hit enter to proceed with Node.Js installation. Be sure to have Node.Js uninstalled beforehand. Restart your command prompt and run `node -v` to verify the download version. You should have the following line `v16.16.0` for a successful download.

    For people who didn't have chocolatey installed or cannot run the command, click this [link][win-2] and install the one suitable for your device. If the link above doesn't work, please navigate to [Node.Js’s official website][win-3], click "Other Downloads" and then select "All download options". There should be a list of download options, click “../” option on the top to view more versions. After installing 16.16.0, restart your command prompt and run `node -v` to verify the download version. You should have the following line `v16.16.0` for a successful download.

- Install Git

    If you have chocolatey installed, run the command: `choco install git.install` in PowerShell with administrator mode to get the newest version of git. Restart your command prompt and run `git --version` to verify the installation.

    For people who didn't have chocolatey installed or cannot run the command, install git from [here][win-4]. Scroll down windows and click the hyperlink to download the Git installer. After installation, restart your command prompt and run `git --version` or `git -v` to verify the installation.

- Create Dream Big folder and clone git repo

    Once Node.Js has been installed, create a folder for where you want the DreamBig project to be stored. Open a terminal window at that location then type in and run `git clone https://github.com/thoth-tech/dream-big`. The DreamBig project should now be copied into the folder you created earlier, open this folder in Visual Code or other code editors of your choice.

- Install Angular

    Navigate a terminal to where the dream-big directory is, then type in and run `npm install -g @angular/cli@latest`, this will install Angular globally onto your system.

- Run Angular server

    Navigate your terminal to dream-big\dream-big-ui and then enter `npx ng serve`, this should start a local development server on your machine which you can use to see how the project is coming along, a few messages will appear and then one like this should show near the bottom: `Angular Live Development Server is listening on localhost:4200, open your browser on http://localhost:4200/`
    
    Open your browser to the address referenced by your terminal, this will allow you to see what the project looks like in its current state, if you make changes to the project and then save it, the browser should update the contents of the page depending on the changes you have made.

- Install Docker

    *This step may take a while, do not shut down your device.*

    If you have chocolatey installed, run the command `choco install docker-desktop` to download docker. Run the Docker application to verify the download.

    For people who didn't have chocolatey installed or cannot run the command, please navigate to the [Docker website][win-5], select the suitable one for your device, and download the installer. Run the Docker application to verify the download.

- Install WSL (Windows Subsystem for Linux)

    *This step may take a while, do not shut down your device.*

    Docker application requires a Linux environment to run. WSL is the best option for windows machines. Open PowerShell, and use the command `wsl --list --online` to view all the available versions of the Linux system. Select your preferred one and download it with `wsl --install -d <name of the machine>`. For example, if you wish to install Ubuntu, just type `wsl --install -d Ubuntu`. 

    If it is your first-time downloading WSL, you might have to enable some features. You can navigate to  “*Control Panel*” => “*Programs*” => “*Programs and Features*” => “*Turn Windows features on or off*”, and find “*Virtual Machine Platform*” and "*Windows Subsystem for Linux*”. Turn both of them on and restart your machine.

    *Note: The WSL features clash with some virtual machine programs and sometimes consume memory. Please consider turning the features off when you don't need them.*

    If you have WSL installed previously, Docker may ask you to upgrade it with a pop-up window. Follow this [link][win-6] to download an update packet. Find the suitable one for your machine and run the downloaded file locally to install the update. 

    Run the application for your just downloaded Linux machine, and follow the prompts to create a new user. Now you can run your Docker application to verify, if there’s no error message showing then you should have your WSL installed successfully.

- Run docker container

    Open a terminal window and navigate to the root folder of the DreamBig project, enter and run the following line `docker compose up`, this will create a docker container that simulates the backend of the project, you can now also start this container by going directly to the Docker GUI program and run the dream-big container in the **Containers/Applications** tab on the left.

***

## **Backend Developer Set Up**

### You need to fork this repository to your GitHub account before continuing

1. Open your terminal and navigate to location where you want to store Dream-Big folder. 

2. Run `git clone https://github.com/[your-github-username]/dream-big`. The folder should be in your location and you can run `code .` to open the folder in visual studio code. Use `git pull` to get the latest version of Dream Big.

3. If `code .` is not working, open the Visual Studio Code application, and type `Command + Shift + P` and type the command `install code`. Then enter it. Visual Studio Application: shell command ' code' successfully installed in PATH will pop up and you will be able to use `code `. to open up visual studio code. 

4. Download [Docker](https://www.docker.com/products/docker-desktop/)

5. After downloading Docker, navigate to your Dream-big folder in terminal and run `docker compose up`(Docker desktop app must be open). This will create a container which will be the backend of the project.

6. After running `docker compose up`(it will host the backend) just navigate to `http://localhost:3000/api/docs#!`. You can now run APIs via swagger.

7. Note: You will have to press migrate APIs if it is your first time going through this.

8. Download [DBeaver](https://dbeaver.io/) and install it for your designated operating system.

9. Connect to the Dream Big database in DBeaver by creating a new MariaDB connection where the details match the [docker compose yaml](./docker-compose.yml). Note if the connection does not work with `host=localhost` a solution is to use `host=0.0.0.0`.


[comment]: # (--------------------The Links for MacOS--------------------)

[mac-1]: <https://nodejs.org/en/download/> "Node-js for mac"

[mac-2]: <https://docs.docker.com/desktop/install/mac-install/> "docker for mac"

[comment]: # (--------------------The Links for Windows--------------------)

[win-1]: <https://chocolatey.org/install> "Chocolatey for win"

[win-2]: <https://nodejs.org/dist/v16.16.0/> "Node.Js 16.16.0 for win"

[win-3]: <https://nodejs.org/en/> "Node.Js's offical website"

[win-4]: <https://git-scm.com/download/win> "Git install"

[win-5]: <https://www.docker.com/get-started/> "Docker"

[win-6]: <https://aka.ms/wsl2kernel> "WSL Update package"

