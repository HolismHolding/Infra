#!/bin/bash

function IsReact() {
    if [ -f "App.js" ] || [ -f "Resources.js" ]; then
        return 1;
    else 
        return 0;
    fi
}

function SetupReact() {
    if [ -f "App.js" ]; then
        echo "React, panel"
        git -C /HolismReact/Infra pull
        git -C /HolismReact/Panel pull
        git -C /HolismReact/Auth pull
        sudo wget -O /setup/ReactDevPanel.yml https://raw.githubusercontent.com/Nefcanto/Infra/main/React/Dev/Panel
        docker-compose -f /setup/ReactDevPanel.yml up
    # elif => $PWD ends with App => it's an app|runnable|host
    else
        if [ -f ".env" ]; then
            echo "React, runnable|host|app"
            docker-compose -f /nefcanto/react-dev-runnable-docker-compose.yml up
        else
            echo "React, reusable|module|package"
            sudo wget -O /setup/react-reusable-compose.yml https://raw.githubusercontent.com/HolismReact/Infra/main/docker-compose.yml
            docker-compose -f /setup/react-reusable-compose.yml up
        fi
    fi
}