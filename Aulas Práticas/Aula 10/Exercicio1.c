static void main(){
    int x, y;
    float result;

    x = 2;
    y = 3;
    result = xtoy(x, y);
    printf("x = %d, y = %d, x^y = %f", x, y, result);
}

static float xtoy(float x, float y){
    int i;
    float result;

    for(i=0, result = 1.0; i < abs(y); i++){
        if (y > 0)
            result *= x;
        else
            result /= x;
    }
    return result;
}

static int abs(int val){
    if (val < 0)
        return -val;
    else
        return val;
}

main();