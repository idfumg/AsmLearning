#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

#define DEVICE "/dev/mydevice"

int main()
{
    const int fd = open(DEVICE, O_RDWR);
    if (fd == -1 ) {
        printf("can not open device file %s\n", DEVICE);
        return -1;
    }

    printf("r = read from device\nw = write to device\nenter command: ");
    char ch;
    scanf("%c", &ch);

    char write_buf[100], read_buf[100];

    switch(ch) {
    case 'w':
        printf("enter data: ");
        scanf(" %[^\n]", write_buf);
        write(fd, write_buf, sizeof(write_buf));
        break;
    case 'r':
        read(fd, read_buf, sizeof(read_buf));
        printf("device: %s\n", read_buf);
        break;
    }

    close(fd);

    return 0;
}
