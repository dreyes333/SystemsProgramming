$1 ~ /[a-z]{3}[0-9]{3}/{

arrOne[$1] = arrOne[$1] "\t"

for( i=8; i <= NF; i++ ) {

    if( $1 in arrOne ){
        arrOne[$1] = arrOne[$1] $i " ";
    }else{
        arrOne[$1] = $i;
    }
}
arrOne[$1] = arrOne[$1] "\n" 

    arrTwo[$0] = $5
}

END{

    n = asorti(arrOne,arrTo)

    for( i = 1; i <= n; i++ ){   
        printf("User: %s\n%s\n",arrTo[i],arrOne[arrTo[i]]);}
    
    eTime="";
    eLine="";
    for(key in arrTwo){
        
        if(eTime == ""){
            eTime = arrTwo[key];
            eLine = key;
        }

        else if(arrTwo[key] < eTime){
            eTime = arrTwo[key];
            eLine = key;
        }
    }

    lTime="";
    lLine="";
    for(key in arrTwo){

        if(lTime == ""){
            lTime = arrTwo[key];
            lLine = key;
        }

        else if(arrTwo[key] > lTime){
            lTime = arrTwo[key];
            lLine = key;
        }
    }

    printf("Earliest Start Time:\n%s\n", eLine);

    printf("\nLatest Start Time:\n%s\n\n", lLine);

}
