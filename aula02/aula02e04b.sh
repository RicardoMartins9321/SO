#!/bin/bash

echo -e "Todos os ficheiros e directorias:\n"
ls  -l -d /etc/*
echo -e "Todos os ficheiros e directorias cujo nome começam por 'a'"
ls -l -d /etc/a*
echo -e "Todos os ficheiros e directorias cujo nome começa por 'a' e tenham mais de 3 caracteres"
ls -l -d /etc/a???*
echo -e "Todos os ficheiros e directorias que têm 'conf' no nome"
ls -l -d /etc/*conf*
