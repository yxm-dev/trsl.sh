#!/bin/bash

# include here the installation directory. Default is XDG $HOME/.config
    installdir="$HOME/.config/trsl.sh"
# including data
    source $installdir/config
    source $installdir/data

# "transl" function
    function trsl() {
## defining auxiliary functions
        
        function exec() {
            read -e -p "> " text;
            touch /tmp/trsl.txt
            echo "$text" > /tmp/trsl.txt
            echo "Translation to ${langname[$1]}:"
            command trans :${lang[$1]} file:///tmp/trsl.txt
            rm /tmp/trsl.txt
        }
       
        if [[ -z $1 ]]; then
            echo "Welcome to trsl-sh. Please, select the language to which you want to translate:"
            for i in ${!Langname[@]}; do
                printf "* ${Langname[$i]} (${lang[$i]})\n"
            done
                    read -e -p "Language to translate: " x
                        if [[ "${Lang[*]}" =~ "$x" ]];then
                            echo "Enter the text to be translated to ${ind_Lang[$x]} ($x)."; 
                            read -e -p "> " text;
                            touch /tmp/trsl.txt
                            echo "$text" > /tmp/trsl.txt
                            echo "Translation to ${langname[$i]}:"
                            command trans :${lang[$i]} file:///tmp/trsl.txt
                            rm /tmp/trsl.txt
                        else
                            echo "Language not identified in the list. Try again? (y/n)" 
                            while :
                            do
                                read -e -p "> " error
                                if [[ $error == "y" ]] || [[ $error == "yes" ]]; then
                                    break
                                    command trsl
                                fi
                                if [[ $error == "n" ]] || [[ $error == "no" ]]; then
                                    break
                                fi
                            echo "Please, write y/yes or n/no."
                            continue
                            done
                        fi
                fi
                for i in ${!lang[@]}; do
                    if [[ $1 == "-${lang[$i]}" ]] || [[ $1 == "--${langname[$i]}" ]] && [[ -z $2 ]]; then
                        echo "Enter the text to be translated to ${langname[$i]}.";
                        read -e "> " text;
                        touch /tmp/trsl.txt
                        echo "$text" > /tmp/trsl.txt
                        echo "Translation to ${langname[$i]}:"
                        command trans :${lang[$i]} file:///tmp/trsl.txt
                        rm /tmp/trsl.txt
                    fi
                done

                if [[ "$1" == "-l" ]] || [[ "$1" == "--languages" ]] || [[ "$1" == "--lang" ]] && [[ -z $2 ]]; then
                    printf "The already configured languages are the following:\n"
                    for i in ${!lang[@]}; do
                        printf "* ${langname[$i]} (${lang[$i]})\n"
                    done
                    printf "To configure additional languages, try \"trsl --config\"\n."
                fi

                if [[ "$1" == "-c" ]] || [[ "$1" == "--configure" ]] || [[ "$1" == "--config" ]] && [[ -z $2 ]]; then
                    if [[ -f $HOME/.config/trsl-sh ]]; then
                        echo "Reconfigure your trsl-sh?. This will overwrite your previous configuration. (y/n)"
                        read -e -p "> " reconfig
                            if [[ $reconfig == "y" ]] || [[ $reconfig == "yes" ]]; then
                                exec "sh $installdir/trsl-sh/config"
                            elif [[ $reconfig == "n" ]] || [[ $reconfig == "no" ]]; then
                                exit
                            else
                                echo "Please, write y/yes or n/no".
                                return
                            fi
                    else
                      exec "sh $installdir/trsl-sh/config"
                    fi
                fi
                if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]] && [[ -z $2 ]]; then
                    printf" trsnl [option] \n\n Options:\n - none option \= interactive mode\n - \"-c\", \"--config\" or \"--configure\" \= configure the lang list;\n - \"-l\", \"--lang\" or \"--languages\" \= list the configured languages;\n - \"-xabbrv\" or \"--xname\", where \"-xabbrv\" is the abbreviation of a language \"x\" in the lang list, and \"--xname\" is its full name \= translate to language \"x\";\n - \"-h\" or \"--help\" \= display this help."  
                fi
    }

