# fpga_uart

![image](https://github.com/user-attachments/assets/f516203c-781d-42fb-bb40-2c5eddaf883d)

# Receiver
Inputs:
1) Clock
2) Baud enable
3) Data length
4) Reset?
5) RX start
6) RX
7) Next msg

Outputs:
1) Data
2) Msg
buffer is not empty

![thumbnail_image](https://github.com/user-attachments/assets/afb98a04-9d87-4f61-b18e-1056e1194ba0)


# Transmiter
Inputs:
1) Clock
2) TX start
3) Data input
4) Baud enable

Outputs:
1) TX
2) TX done

![thumbnail_image](https://github.com/user-attachments/assets/048f75a0-91db-4b56-8333-fce31b304478)

Output of uart_tx will be connected to the input of a LIFO buffer. 

