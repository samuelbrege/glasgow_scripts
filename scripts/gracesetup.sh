#!/bin/sh
#
#~ND~FORMAT~MARKDOWN~
#~ND~START~
#
# ## COPYRIGHT NOTICE
#
# Copyright (C) 2015 Anticevic Lab, Yale University
# Copyright (C) 2015 MBLAB, University of Ljubljana
#
# ## PRODUCT
#
# * Global environment script for N3 Software Repos
#
# ## LICENSE
#
#
#
# ## Description:
#
# * This is a general script developed as a front-end environment and path organization for the HPC infrastructure
# * This script needs to be sourced in each users .bash_profile like so:
#
# TOOLS=/gpfs/gibbs/pi/n3/software/bin/globalsetup.sh
# export TOOLS
# source $TOOLS/bin/globalsetup.sh
#
# ### Installed Software (Prerequisites) sourced by $TOOLS/bin/globalsetup.sh
#
# * QuNex Suite & all dependencies
#
#~ND~END~

###########################################################################################################################
###################################################  CODE START ###########################################################
###########################################################################################################################

# ------------------------------------------------------------------------------
#  Setup color outputs
# ------------------------------------------------------------------------------

BLACK_F="\033[30m"; BLACK_B="\033[40m"
RED_F="\033[31m"; RED_B="\033[41m"
GREEN_F="\033[32m"; GREEN_B="\033[42m"
YELLOW_F="\033[33m"; YELLOW_B="\033[43m"
BLUE_F="\033[34m"; BLUE_B="\033[44m"
MAGENTA_F="\033[35m"; MAGENTA_B="\033[45m"
CYAN_F="\033[36m"; CYAN_B="\033[46m"
WHITE_F="\033[37m"; WHITE_B="\033[47m"

reho() {
    echo -e "$RED_F$1 \033[0m"
}

geho() {
    echo -e "$GREEN_F$1 \033[0m"
}

yeho() {
    echo -e "$YELLOW_F$1 \033[0m"
}

beho() {
    echo -e "$BLUE_F$1 \033[0m"
}

mageho() {
    echo -e "$MAGENTA_F$1 \033[0m"
}

cyaneho() {
    echo -e "$CYAN_F$1 \033[0m"
}

weho() {
    echo -e "$WHITE_F$1 \033[0m"
}


# ------------------------------------------------------------------------------
#  setup server login messages
# ------------------------------------------------------------------------------


HOST=`hostname`
NetID=`whoami`

# ------------------------------------------------------------------------------
#  Setup master software folder
# ------------------------------------------------------------------------------

N3FOLDER=/gpfs/gibbs/pi/n3
TOOLS=/gpfs/gibbs/pi/n3/software
export TOOLS
export N3FOLDER

# ------------------------------------------------------------------------------
#  License disclaimer
# ------------------------------------------------------------------------------

geho ""
geho "      \  |  ___ /       __ \   _)           _)         _)                    "
geho "       \ |    _ \       |   |   |  \ \   /   |    __|   |    _ \    __ \     "
geho "     |\  |     ) |      |   |   |   \ \ /    |  \__ \   |   (   |   |   |    "
geho "    _| \_|  ____/      ____/   _|    \_/    _|  ____/  _|  \___/   _|  _|    "
geho ""
geho "               at Yale University Department of Psychiatry                   "
geho ""
geho "                     Software Licence Disclaimer:                            "
geho "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
geho " Use of this software is subject to the terms and conditions defined by the  "
geho " Yale University Copyright Policies:                                         "
geho "    http://ocr.yale.edu/faculty/policies/yale-university-copyright-policy    "
geho " and the terms and conditions defined in the file 'LICENSE.txt' which is     "
geho " a part of this source code package.                                         "
geho "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
geho "                                                                             "
geho "    ==> Setting up HPC environment and paths ...                             "
geho ""
geho "    --> You are logged in as $NetID on `hostname`                            "
geho "    --> Studies folder:           $N3FOLDER/Studies                          "
geho "    --> Software folder:          $N3FOLDER/software                         "
geho "                                                                             "
geho "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
geho ""

# ------------------------------------------------------------------------------
#  Setup privileges and environment disclaimer
# ------------------------------------------------------------------------------

grep -qxF "umask 002" ~/.bashrc || echo "umask 002" >> ~/.bashrc
. ~/.bashrc

export PATH=/gpfs/gibbs/pi/n3/software/dataorc-bin:$PATH
export PATH=/gpfs/gibbs/pi/n3/software/dcmtk-3.6.7/bin/:$PATH

# --- Set up prompt
PS1="\[\e[0;36m\][Grace \W]\$\[\e[0m\] "
PROMPT_COMMAND='echo -ne "\033]0;Grace: ${PWD}\007"'

unset FSL_DIR FSLDIR
#module --force purge
#module load StdEnv
# module load foss/2018a
# module load Langs/Python/2.7.14
# module load Python/2.7.14-foss-2018a
#CONDADIR=/apps/hpc.rhel7/Langs/Python/2.7.15-anaconda
#export CONDADIR

# -- Octave path
#module load Octave/4.2.1-foss-2018a
#OCTAVEDIR="/gpfs/loomis/apps/avx/software/Octave/4.2.1-foss-2016b/bin/octave"
#export OCTAVEDIR

#module load GCCcore/6.4.0
module load miniconda/23.5.2

# -- Matlab path
# module load MATLAB/2023a
# MATLABDIR="/gpfs/gibbs/apps/avx/software/MATLAB/2021a/bin/matlab"
# export MATLABDIR

# -- R path
#module load R/4.3.0-foss-2020b &> /dev/null
#RDIR="/gpfs/gibbs/apps/avx/software/R/4.0.3-foss-2020b/bin/R"
#export RDIR

# -- QX useful paths
export QX_CONTAINERS="${TOOLS}/Singularity"
export QX_AT_FOLDER="${TOOLS}/qunexsdk/qunexaccept"
export QX_AT_RESULTS="${N3FOLDER}/Studies/QuNexAcceptTest/Results"

#module load GCCcore/5.4.0
#module load OpenBLAS/0.2.18-GCC-5.4.0-2.26-LAPACK-3.6.1

# ------------------------------------------------------------------------------
#  Load QuNex Environment
# ------------------------------------------------------------------------------

if [ -z ${QUNEXREPO} ]
then
    QUNEXREPO="qunex"
fi

# -- Add path to /bin and /env

export PATH=${TOOLS}/${QUNEXREPO}/library/bin/:${PATH}


# FreeSurfer binaries for Grace ==> The following results in an error missing library libXmu.so.6
#. /gpfs/apps/hpc/Apps/FREESURFER/5.3.0/freesurfer/FreeSurferEnv.sh &> /dev/null
#. /gpfs/apps/hpc/Apps/FREESURFER/5.3.0-HCP/FreeSurferEnv.sh  &> /dev/null

# ------------------------------------------------------------------------------
#  Setup Aliases
# ------------------------------------------------------------------------------

# -- Path and command aliases
NetID=`whoami`
alias cterm='bsub -q anticevic -Is bash'
alias crun='bsub -q anticevic -Is '
alias n3='cd ${N3FOLDER}'
alias tools='cd ${TOOLS}'
alias studies='cd ${N3FOLDER}/Studies'
alias admin='cd ${N3FOLDER}/admin'
alias mlab='matlab -nojvm -nodisplay'
alias ll='ls -lah'
#alias setaclsuser='/bin/bash /gpfs/gibbs/pi/n3/admin/setup_acls_n3_user.sh'
#alias setaclsadmin='/bin/bash /gpfs/project/fas/n3/admin/setup_acls_n3_admindev.sh'

# -- Slurm aliases
alias sshbigmem='srun --pty -p pi_anticevic_bigmem --time=7-00:00:00 --ntasks-per-node=1 --mem=50000 bash -l'
alias sshcpu='srun --pty -p pi_anticevic --ntasks-per-node=1 --time=2-00:00:00 --mem=20000 bash -l'
alias sshgpu='srun --pty -p pi_anticevic_gpu --ntasks-per-node=1 --time=2-00:00:00 --mem=40000 --gres=gpu:2 bash -l'
alias sshcpuweek='srun --pty -p week --time=2-00:00:00 --mem=20000 bash -l'
alias sshcpuday='srun --pty -p day --time=20:00:00 --mem=20000 bash -l'

# -- ssh aliases
#alias louise='ssh $NetID@louise.hpc.yale.edu'
#alias omega='ssh $NetID@omega.hpc.yale.edu'
alias qunexdev='cd $TOOLS/qunexdev/'

# -- Misc aliases
alias countdir='ls | wc'
alias lls='echo "$(ls)"'
#alias ls="ls -G"
alias sinfolong='sinfo -N -p pi_anticevic --long'
alias profilereload='cd; source .bash_profile'

# -- Z Aliases
alias shred='ssh zailyn@shred.med.yale.edu'
alias znode='srun --pty -p pi_anticevic_z -A anticevic_z --ntasks-per-node=1 --time=2-00:00:00 --mem=20000 bash -l'

# -- Node usage function
function_sysusage() {
	CurrentNode=`hostname`
	echo ""
	cyaneho "------------- System usage for: $CurrentNode ---------------"
	echo ""
	free -m | awk 'NR==2{printf "  --> Memory Usage:   %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
	df -h | awk '$NF=="/"{printf "  --> Disk Usage:     %d/%dGB (%s)\n", $3,$2,$5}'
	top -bn1 | grep load | awk '{printf "  --> CPU Load:       %.2f\n", $(NF-2)}'
	echo ""
}
alias sysusage=function_sysusage

# -- Kill pending jobs
function_bkillpend() {
	jobs=`bjobs | grep "PEND" | awk {'print $1'}`
	for job in $jobs; do bkill $job; done
}
alias bkillpend=function_bkillpend

# -- Kill running jobs
function_bkillrun() {
	jobs=`bjobs | grep "RUN" | awk {'print $1'}`
	for job in $jobs; do bkill $job; done
}
alias bkillpend=function_bkillpend

# -- Kill stuck jobs
function_bkillstuck() {
	jobs=`bjobs | grep "UNKWN" | awk {'print $1'}`
	for job in $jobs; do bkill $job; done
}
alias bkillpend=function_bkillpend