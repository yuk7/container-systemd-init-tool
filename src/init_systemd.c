/*
 * Copyright (c) 2020 yuk7
 * Author: yuk7 <yukx00@gmail.com>
 *
 * Released under the MIT license
 * http://opensource.org/licenses/mit-license.php
 */

#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>

int main (int argc, char *argv[])
{
	uid_t uid = getuid();

	setuid(0);


	
	char **cmd;
	cmd = malloc(sizeof(char*) * (argc + 4));

	char shell[] = "/usr/.bin/bash";
	cmd[0] = malloc((strlen(shell) + 1) * sizeof(char));
	strcpy(cmd[0], shell);

	cmd[1] = malloc((2 + 1) * sizeof(char));
	strcpy(cmd[1], "--");

	char script[] = "/init_wsl2/script.sh";
	cmd[2] = malloc((strlen(script) + 1) * sizeof(char));
	strcpy(cmd[2], script);

	for (int i = 1; i < argc; i++)
	{
		cmd[i+2] = malloc((strlen(argv[i]) + 1) * sizeof(char));
		strcpy(cmd[i+2], argv[i]);
	}
	cmd[argc+2] = NULL;
	
	char uidStr[10];
	sprintf(uidStr, "%d", uid);
	setenv("INIT_WSL_UID", uidStr, 1);
	execv(shell, cmd);
	exit(-1);
}