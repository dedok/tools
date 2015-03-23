void packi32(unsigned char *buf, int i)
{
    *buf++ = i >> 24;
    *buf++ = i >> 16;
    *buf++ = i >> 8;
    *buf++ = i;
}

int unpacki32(unsigned char *buf)
{
    return
        (buf[0] << 24) +
        (buf[1] << 16) +
        (buf[2] << 8) +
        buf[3];
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct some_data
{
    int version;
    char flag;
    size_t str_size;
    char * str;
} some_data_t;

void write(some_data_t *sd, FILE *out)
{
    fwrite((void*)&sd->version, sizeof(sd->version), 1, out);
    fwrite((void*)&sd->flag, sizeof(sd->flag), 1, out);
    fwrite((void*)&sd->str_size, sizeof(sd->str_size), 1, out);
    fwrite((void*)&sd->str, sizeof(*sd->str), sd->str_size, out);
}

void read(some_data_t *sd, FILE *in)
{
    fread((void*)&sd->version, sizeof(sd->version), 1, in);
    fread((void*)&sd->flag, sizeof(sd->flag), 1, in);
    fread((void*)&sd->str_size, sizeof(sd->str_size), 1, in);
    fread((void*)&sd->str, sizeof(*sd->str), sd->str_size, in);
}

int main(int argc, char ** argv)
{
    (void)argc;

    unsigned char buf[4];
    int d = atoi(argv[1]);
    packi32(buf, d);
    fprintf(stderr, "result: %d\n", unpacki32(buf));

    return 0;

    some_data_t data = {1, 2, sizeof("Hello binary data!") - 1,
        "Hello binary data!"};
    FILE *f = fopen("out.bin", "w+");
    if (f == NULL) {
        perror("fopen");
        return 1;
    }
    write(&data, f);
    fclose(f);

    memset(&data, 0, sizeof(some_data_t));
    f = fopen("out.bin", "r");
    if (!f) { perror("fopen"); return 1; }
    read(&data, f);

    printf("ver:%d, flag:%c, str_size:%zu, str:%s\n",
            data.version, data.flag, data.str_size, data.str);

    return 0;
}
