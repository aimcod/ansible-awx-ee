if [ -z $1 ]
then
        echo please provide the build number.

        exit 1

elif [ $1 -ge 9 ]
        then
                echo you\'ve reached maximum small version build numbers. please adjust.

        else

                python -m venv builder

                source builder/bin/activate

                ansible-builder build --tag quay.io/andreichnla/awx-ee:1.0.$1 --tag quay.io/andreichnla/awx-ee:latest --context ./ --verbosity 3
                podman login -u="xxxxxxx" -p="xxxxxxxxxxxxxx" quay.io
                podman push quay.io/andreichnla/awx-ee:1.0.$1
                podman push quay.io/andreichnla/awx-ee:latest

fi
