#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdarg.h>

#define APARTMENT_FILE "apartments.dat"
FILE *binaryDirect;


typedef struct {
    char firstName [32];
    char lastName [32];
    char leaseStart [16];
    char leaseEnd [16];
    int balance ;
} Apartment ;

void createApt();
void readAptData();
void updateAptData();
void deleteApt();

int main( int argc, char *argv[] ) {

    char buffer[100];
    char userCommand;
    
    binaryDirect = fopen(APARTMENT_FILE,"rb+");
    if(binaryDirect == NULL){
        binaryDirect = fopen(APARTMENT_FILE, "wb+");
    }

        while(fgets(buffer, 100, stdin) != NULL){

            if (buffer[0] == '\n')
                continue;

             printf("\nEnter one of the the following actions or press CTRL-D to exit.\n");
             printf("C - create a new apartment record\n");
             printf("R - read an existing apartment record\n");
             printf("U - update an existing apartment record\n");
             printf("D - delete an existing apartment record\n");

            sscanf(buffer, "%c", &userCommand);

            switch(userCommand)
            {
                case 'c':
                case 'C':

                    createApt();
                    break;
                case 'r':
                case 'R':

                    readAptData();
                    break;

                case 'u':
                case 'U':
            
                    updateAptData();
                    break;

                case 'd':
                case 'D':

                    deleteApt();
                    break;

                default:

                    printf("\nERROR: invalid option\n");

            }        
        }

    fclose(binaryDirect);
}

void createApt(){
    
    Apartment apt;
    int aptnum;
    int balance = 900;
    int fseekRet;
    int fwriteCount;
    int freadCount;
    int aptPosition;
    char fName[32] = "";
    char lName[32] = "";
    char lStart[16] = "";
    char lEnd[16] = "";

    printf("\nEnter an apartment number: \n");
    scanf("%i", &aptnum);

    getchar();

    printf("Enter the first name: \n");
    fgets(fName, 32, stdin);

    printf("Enter the last name: \n");
    fgets(lName, 32, stdin);

    printf("Enter the lease start date (MM/DD/YYYY): \n");
    fgets(lStart, 16, stdin);

    printf("Enter the lease end date (MM/DD/YYYY): \n");
    fgets(lEnd, 16, stdin);
    
    aptPosition = aptnum * sizeof(Apartment);
    fseekRet = fseek(binaryDirect,aptPosition,SEEK_SET);
    if(fseekRet != 0){
        printf("Seek was not successful!\n"); 
        return;}

    freadCount = fread(&apt, sizeof(Apartment), 1L, binaryDirect);

    if(freadCount == 1){
        printf("ERROR: apartment already exists\n");
        return;}

    strcpy(apt.firstName,fName);
    strcpy(apt.lastName, lName);
    strcpy(apt.leaseStart, lStart);
    strcpy(apt.leaseEnd, lEnd);
    apt.balance = balance;

    fseekRet = fseek(binaryDirect,aptPosition,SEEK_SET);
    if(fseekRet != 0){
        printf("Seek was not successful!\n");
        return;}

    fwriteCount = fwrite(&apt, sizeof(Apartment), 1L, binaryDirect); 
    if(fwriteCount == 1){
        printf("New apartment record %i successfully created\n", aptnum);
    }else{
        printf("No apartment created!\n");
    }

}

void readAptData(){
    
    Apartment apt;
    int aptPosition;
    int aptnum; 
    int fseekRet;
    int freadCount;

    printf("Enter an apartment number: \n");
    scanf("%i", &aptnum);

    aptPosition = aptnum * sizeof(Apartment);
    fseekRet = fseek(binaryDirect,aptPosition,SEEK_SET);
    if(fseekRet != 0){
        printf("Seek was not successful!\n"); 
        return;}

    freadCount = fread(&apt, sizeof(Apartment), 1L, binaryDirect);
    if(freadCount == 1){
        printf("Apartment Number: %i\n", aptnum);
        printf("Tenant Name: %s, %s\n", apt.lastName, apt.firstName);
        printf("Lease Start: %s\n", apt.leaseStart);
        printf("Lease End: %s\n", apt.leaseEnd);
        printf("Current Balance: %i\n", apt.balance);
    }else{
        printf("ERROR: apartment not found\n");
        return;
    }

}

void updateAptData(){
    
    Apartment apt;
    int aptPosition;
    int fseekRet;
    int freadCount;
    int fwriteCount;
    int aptnum;
    char fName[32] = "";
    char lName[32] = "";
    char lStart[16] = "";
    char lEnd[16] = "";
    char balance[16] = "";
    int newBalance;
    
    printf("Enter an apartment number: \n");
    scanf("%i", &aptnum);

    getchar();

    printf("Enter the first name: \n");
    fgets(fName, 32, stdin);

    printf("Enter the last name: \n");
    fgets(lName, 32, stdin);

    printf("Enter the lease start date (MM/DD/YYYY): \n");
    fgets(lStart, 16, stdin);

    printf("Enter the lease end date (MM/DD/YYYY): \n");
    fgets(lEnd, 16, stdin);

    printf("Enter the account balance: \n");
    fgets(balance, 16, stdin);
    newBalance = atoi(balance);

    aptPosition = aptnum * sizeof(Apartment);
    fseekRet = fseek(binaryDirect,aptPosition,SEEK_SET);
    if(fseekRet != 0){
        printf("Seek was not successful!\n");
        return;}

    freadCount = fread(&apt, sizeof(Apartment), 1L, binaryDirect);

    if(freadCount != 1){
        printf("ERROR: apartment not found\n");
        return;}

    fseekRet = fseek(binaryDirect,aptPosition,SEEK_SET);    
    if(fseekRet != 0){
        printf("Seek was not successful!\n");
        return;}

    strcpy(apt.firstName,fName);
    strcpy(apt.lastName, lName);
    strcpy(apt.leaseStart, lStart);
    strcpy(apt.leaseEnd, lEnd);
    apt.balance = newBalance;

    fwriteCount = fwrite(&apt, sizeof(Apartment), 1L, binaryDirect); 
    if(fwriteCount == 1){
        printf("Apartment record %i succesfully updated!\n", aptnum);
    }else{
        printf("Apartment record %i could not be updated!\n", aptnum);
    }

}

void deleteApt(){
    
    Apartment apt;
    int aptnum;
    int fseekRet;
    int freadCount;
    int fwriteCount;
    int aptPosition;
    char fName[32] = "";
    char lName[32] = "";
    char lStart[16] = "";
    char lEnd[16] = "";
    int balance = 0;

    printf("Enter an apartment number: \n");
    scanf("%i", &aptnum);

    aptPosition = aptnum * sizeof(Apartment);
    fseekRet = fseek(binaryDirect,aptPosition,SEEK_SET);
    if(fseekRet != 0){
        printf("Seek was not successful!\n");
        return;}

    freadCount = fread(&apt, sizeof(Apartment), 1L, binaryDirect);

    if(freadCount != 1){
        printf("ERROR: apartment not found\n");
        return;}

    if(freadCount == 1 && apt.firstName != ""){        

        fseekRet = fseek(binaryDirect,aptPosition,SEEK_SET); 
    
        if(fseekRet != 0){
            printf("Seek was not successful!\n");
            return;}

        strcpy(apt.firstName,fName);
        strcpy(apt.lastName, lName);
        strcpy(apt.leaseStart, lStart);
        strcpy(apt.leaseEnd, lEnd);
        apt.balance = balance;

        fwriteCount = fwrite(&apt, sizeof(Apartment), 1L, binaryDirect);

        if(fwriteCount == 1 && strcmp(apt.firstName, "") == 0)
            printf("Record %i was successfully deleted\n", aptnum);
    
    }
     
}
