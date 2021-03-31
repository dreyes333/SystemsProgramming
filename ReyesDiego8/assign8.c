#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/wait.h>

int main (int argc, char *argv[]){

    long forkRet; 
    long waitRet;
    int i = 1;
    char *execArgv[5];
    int y;
    int iExitStatus;
    int j = 0;

    for(y = 0; y < 5; y++){ //sets execArgv to null
        execArgv[y] = NULL;
    }
    
    for( i = 1; i < argc; i++){
        
        // if argv[i] is not a comma
        if(strcmp(argv[i], ",") != 0){
            execArgv[j] = (char*)malloc(21);
            strcpy(execArgv[j],argv[i]);  
            j++;  
        }else{
            forkRet = fork();    
            switch(forkRet)
            {
                case -1:
                    printf("fork failed: %s\n", strerror(errno));
                    break;
                case 0:
                    fprintf(stderr,"Child Process: PID=%ld, PPID=%ld, CMD: %s\n", (long) getpid(), (long) getppid(), execArgv[0]);
                    execvp(execArgv[0], execArgv);
                    printf("Child process failed to exec: %s\n", strerror(errno));
                default:
                    printf(" ");
            }

            //make j = 0 for next command
            j = 0;         
            // makes execArgv NULL to repeat proccess 
            for(y = 0; y < 5; y++){
                execArgv[y] = NULL;
            }
        }
    }
    
    if( NULL == execArgv[0] ){
        printf("\nexecArgv[0] is NULL\n");
    }

    if( NULL != execArgv[0] ){
        
        forkRet = fork();

        if( 0 == forkRet ){
            fprintf(stderr,"Child Process: PID=%ld, PPID=%ld, CMD: %s\n", (long) getpid(), (long) getppid(), execArgv[0]);
            execvp(execArgv[0], execArgv);
        }
    }
    
    while ( (waitRet = wait(&iExitStatus) > 0) ){
        if (waitRet == -1)
            printf("wait error: %s", strerror(errno));
        if (WIFEXITED(iExitStatus) != 0)
            continue;
        if (WIFSIGNALED(iExitStatus) != 0)
            continue;
    }  

}
