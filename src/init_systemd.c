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
	int status;
	pid_t pid;
	uid_t uid = getuid();

	setuid(0);
	if (pid = fork() == 0)
	{
		execl("/usr/.bin/bash", "/usr/.bin/bash", "-c", "/init_wsl2/prepare.sh", NULL);
		exit(-1);
	}
	else if(pid != -1)
	{	
		wait(&status);
		if (WIFEXITED(status) || WIFSIGNALED(status))
		{
			char *cmd;
			int cmdLen = 0;
			char script[] = "/init_wsl2/script.sh ";

			cmdLen += strlen(script);
			for (int i = 1; i < argc; i++)
			{
				cmdLen += strlen(argv[i]) + 1;
			}
			cmd = (char *)malloc((cmdLen + 2) * sizeof(char));
			strcpy(cmd, script);
			for (int i=1; i < argc; i++)
			{
				strcat(cmd, argv[i]);
				strcat(cmd, " ");
			}

			char uidStr[10];
			sprintf(uidStr, "%d", uid);
			setenv("INIT_WSL_UID", uidStr, 1);
			execl("/usr/bin/bash", "/usr/bin/bash", "-c", cmd, NULL);
			exit(-1);
		}
	}
}
