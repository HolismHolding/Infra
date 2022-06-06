#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
cyan=`tput setaf 6`
magenta=`tput setaf 5`
yellow=`tput setaf 3`
reset=`tput sgr0`

function Success()
{
    echo "${green}$*${reset}"
}

function Info()
{
    echo "${cyan}$*${reset}"
}

function Warning()
{
    echo "${yellow}$*${reset}"
}

function Error()
{
    echo "${red}$*${reset}"
}

function Divide()
{
    echo ""
    echo "${magenta}----------${reset}"
    echo ""
}