#Use this file to set environment variables and aliases
#
##Do not try to edit ~/.cshrc, ~/.tcshrc or ~/.login

# example companyterm window size and font - uncomment to use
# #setenv XTERM_FONT screen15
# #setenv XTERM_GEOM 80x40
#
# # default PATH set up

set history = 2000          # History remembered is 2000
set savehist = (2000 merge) # Save and merge with existing saved 
set histfile = ~/hist/.tcsh_history.$HOSTNAME
  # Set long hostname
  set hostname = `hostname -f`

# set the prompt

if ( $?prompt ) then
    switch ($UNAME)
    case "irix":
        if ($SHELL == "/bin/tcsh" ) then
        set con1 = %B
        set con2 = %B
        set coff = %b
        else
        set con1 = '^[[1m'
        set con2 = '^[[2m'
        set coff = '^[[0m'
        endif
        breaksw
    case "linux":
        set con1 = %B
        set con2 = %B
        set coff = %b
        breaksw
    default:
        set con1 = ""
        set con2 = ""
        set coff = ""
        breaksw
    endsw

    if ( -o /bin/su ) then
        #su root prompt
        set prompt = "$whoami""@""${hostname}:$con1$cwd $con2# $coff"
        alias cd       'cd \!:*; set prompt = "$whoami""@""${hostname}:$con1$cwd $con2# $coff"'
        alias popd     'popd \!:*; set prompt = "$whoami""@""${hostname}:$con1$cwd $con2# $coff"'
        alias pushd    'pushd \!:*; set prompt = "$whoami""@""${hostname}:$con1$cwd $con2# $coff"'
    else
        #user prompt
        set prompt = "$whoami""@""${hostname}:$con1$cwd > $coff"
        alias cd       'cd \!:*; set prompt = "$whoami""@""${hostname}:$con1$cwd > $coff"'
        alias popd     'popd \!:*; set prompt = "$whoami""@""${hostname}:$con1$cwd > $coff"'
        alias pushd    'pushd \!:*; set prompt = "$whoami""@""${hostname}:$con1$cwd > $coff"'
    endif
endif

 # Make tcsh more like bash
 bindkey '^[[1;5C' forward-word
 bindkey '^[[1;5D' backward-word
 bindkey ^W	backward-delete-word 
 unset ignoreeof
 set complete = enhance
 complete sudo 'n/-l/u/' 'p/1/c/'

 # Disable host key verifacation for PDSH
 setenv PDSH_SSH_ARGS_APPEND '-o StrictHostKeyChecking=no'

 # SSH auto completion
 set hosts = `sed -e 's/^ *//' -e '/^#/d' -e 's/[, ].*//' -e '/\[/d' ~/.ssh/known_hosts | sort -u`
 complete ssh 'p/1/$hosts/' 'p/2/c'

 # Set Path variable
 setenv PATH $HOME/tools/scripts:$HOME/tools/bin/${UNAME}:$HOME/bin:/sbin:${PATH}

 # Make PDSH bend to my will
 setenv PDSH_SSH_ARGS_APPEND "-oBatchMode=yes -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

 # My aliases
 alias ssh 'ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
 alias please 'sudo \!-1'
 alias less less -imS
 alias df 'df -h'
 alias du 'du -h'
 alias snoop 'sudo x11vnc -display :0'
 alias pz 'cd /disk1/tools/bind/var/pz/'
 alias sl '/usr/bin/sl'
 alias tmpclear 'sudo tmpwatch -u 7 /disk1/tmp'

# #### Do not delete this line or add anything below this line ####