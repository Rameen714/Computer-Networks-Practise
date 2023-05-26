#include <stdio.h> 
#include <string.h> 
#include <sys/socket.h> 
#include <arpa/inet.h> 

int main(void)
{
      int socket_desc;
      
      char** arr = NULL;
      int count = 0;
      FILE *f;
      f = fopen("file.txt","a+");
      
      struct sockaddr_in server_addr, client_addr;
      
      char server_msg[2000], client_msg[2000];
      int client_struct_length = sizeof(client_addr);
      
      //cleaning the buffers
      
      memset(server_msg,'\0',sizeof(server_msg));
      memset(client_msg,'\0',sizeof(client_msg));
      
      //creating udp socket
      
      socket_desc = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
      
      if(socket_desc < 0)
      {
      	printf("Could not create socket. Error!!!!!\n");
      	return -1;
      }
      printf("Socket Created\n");
      
      //binding ip and port to socket
      
      server_addr.sin_family = AF_INET;
      server_addr.sin_port = htons(2010);
      server_addr.sin_addr.s_addr = inet_addr("127.0.0.1");
      
      if(bind(socket_desc,(struct sockaddr*)&server_addr, sizeof(server_addr)) < 0)
      {
      	printf("Bind failed. Error!!!!\n");
      	return -1;
      }
      
      printf("Bind done");
      printf("Listening for msgs...\n\n");


	while(1)
	{
        //Receive the message from the client
		  
		  if( recvfrom(socket_desc, client_msg, sizeof(client_msg),0,(struct sockaddr*)&client_addr,&client_struct_length) < 0 )
		  {
		  	printf("recieve failed.Error.......\n\n");
		  	return -1;
		  }
		  
		  printf("recieved msg from IP: %s anmd Port No: %i\n",inet_ntoa(client_addr.sin_addr),ntohs(client_addr.sin_port) );
		  
		  printf("Client msg: %s\n",client_msg);
		  
		  //send the msg back to client
		  
		  strcpy(server_msg, client_msg);
		  
		  if(sendto(socket_desc,server_msg,strlen(server_msg),0,(struct sockadddr*)&client_addr,client_struct_length) < 0 )
		  {
		  	printf("Send failed.Error!!!!!!!!\n");
		  	return -1;
		  }
		  
		  f = fopen("file.txt","a+");
		  fprintf(f,client_msg);
		  close(f);
		  
		  /*
		  int length = strlen(client_msg);
		  int i = 0,j = 0;
		  for(i = 0; i < length; i++)
			  arr[count][i] = client_msg[i];
		  
		  for(i = 0; i < count ; i++)
			  for(j=0; j < length; j++)
			  	printf("\n%c",arr[i][j]);
		  count++;
		  */
		  memset(server_msg,'\0',sizeof(server_msg));
		  memset(client_msg,'\0',sizeof(client_msg));
      	
      } 
      
      
      close(socket_desc);
      return 0;
      
}
