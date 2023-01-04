The following explains what is required to build an AWX-EE.

I personally have a dedicated machine at work for this task, that is part of the awx cluster, so I do all my EE business there, but anyone can build an EE with these instructions, on any machine with an internet connection.
Preferably linux. 

I will just list the package manager dependecies here:

RHEL Systems: podman, python39, python39-pip

Debian Systems: docker, python3.9, python3.9-pip

Newer versions of python should work too. 

Once you get pip installed, use pip to install ansible and ansible-builder.

I highly recomend reading the docs, as things will only get simpler for you, if you know what you're doing, although this is fairly straigt forward.
https://ansible-builder.readthedocs.io/en/stable/installation/

```
pip install ansible
pip install ansible-builder 
```

You will need to create a folder for your new project then create a virtual environment in that folder, then source from the activate script. 
Again, the docs are important.
https://docs.python.org/3.4/library/venv.html

```
mkdir ~/ansible-builder && cd ~/ansible-builder
python -m venv builder
source builder/bin/activate

```

You will also need to provide yourself with access to an image registry. 
https://quay.io/
https://podman.io/
https://www.docker.com/

I use quay and the EE I've built with the resources in this repo can be found at https://quay.io/repository/andreichnla/awx-ee

Once all the prerequisites are completed, download the whole repo, update the doBuild.sh script with your own details, then run it.

I have left the following lines, except the repo login, as they are in the script, howver you will need to update these 3 lines with your own details.
```
ansible-builder build --tag quay.io/andreichnla/awx-ee:1.0.$1 --tag quay.io/andreichnla/awx-ee:latest --context ./ --verbosity 3
podman login -u="yourimagerepositoryuser" -p="yourimagerepositorytoken" quay.io
podman push quay.io/andreichnla/awx-ee:1.0.$1
podman push quay.io/andreichnla/awx-ee:latest
```

Feel free to edit your own requirements.txt, requirements.yml, execution-environment.yml, bindep.txt.

You will note that the requirements.yml file contains a list of collections that can be found here:
https://docs.ansible.com/ansible/latest/collections/community/index.html

Any collection that can be installed with ansible-galaxy can be specified in the requirements.yml file.
For more info, again, docs:
https://galaxy.ansible.com/docs/using/installing.html#installing-multiple-roles-from-a-file

The execution-enviornment.yml file is a manifest that describes to ansible-builder, the list of steps it needs to take in order to build the image, as well as any added OS level customization, for the image's OS.


Once you have every config file set, you can run `./doBuild x` where x is the sub-version number. I suggest starting from 0. 


