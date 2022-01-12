#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
cyan=`tput setaf 6`
magenta=`tput setaf 5`
yellow=`tput setaf 3`
reset=`tput sgr0`

function Success()
{
    echo "${green}$1${reset}"
}

function Info()
{
    echo "${cyan}$1${reset}"
}

function Warning()
{
    echo "${yellow}$1${reset}"
}

function Error()
{
    echo "${red}$1${reset}"
}

function Divide()
{
    sudo echo ""
    sudo echo "${magenta}----------${reset}"
    sudo echo ""
}