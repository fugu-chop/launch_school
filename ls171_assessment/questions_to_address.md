### What is the internet?
The internet can be described as a network of networks - it allows for the communication between devices and the transfer of information across different networks, through various protocols operating at different 'layers', where each layer has it's own responsibility for the transmission of information and is 'independent' from other layers, in that the specific information and implementation at one layer is abstracted away from another layer through the encapsulation of a _protocol data unit_.

### What is a network?
A network, at it's simplest implementation, is two devices connected in such a way that they are able to communicate or exchange data between themselves. The key is that communications are limited to devices that exist within the network and are connected to each other (either directly, or through a switch or hub) - i.e. the Local Access Network (LAN). 

Communication within a network is handled by the Link/Data Link layer, which establishes protocols that enable the devices that are connected to each other on the LAN to communicate to each other through a protocol. An example protocol at the Link/Data Link Layer is the Ethernet Protcol, which incorporates both physical hardware specifications (e.g. how an CAT6 cable should be constructed) and logical transmission of information, through __addressing__ (determining which device to send information to) and __framing__ (structuring the information to be transmitted so that the other device is able to interpret it).

### What is a protocol?
Fundamentally, protocols are a _system of rules that govern the exchange or transmission of data_. Protocols exist across:
- Different _aspects_ of communication, e.g. across different functions of network communication, such as transmission of information __between__ networks (e.g. the Internet Protocol on the Internet/Network Layer) and transmission __within__ a network (e.g. the Ethernet Protocol in the Link/Data Link layer); and
- The _same_ aspect of communication, depending on the use case (e.g. TCP or UDP on the Transport layer).

### Explain the 'layered system'
The layered system is a mental model that we can adopt to group different protocols in respect of the particular aspect of communication that they address. Protocols (depending on the layered system used) can be thought of as operating at a single, particular 'layer', to represent the system of rules for transmitting information at a particular step of the information transmission process.

There are two popular 'layered' network communication models that describe the information transmission process; the OSI (Open Systems Interconnection) model, and the Internet Protocol Suite. They are roughly equivalent (though some overlap does occur) in respect of the 'layers' that they describe:
- The top layer of the Internet Protocol Suite (Application) mostly maps to the top three layers of the OSI Model (Application, Presentation, Session).
- The second layer of the Internet Protocol Suite (Transport) mostly maps to the fourth layer of the OSI model (Transport)
- The third layer of the Internet Protocol Suite (Internet) mostly maps to the fifth layer of the OSI model (Network)
- The fourth layer of the Internet Protocol Suite (Link) mostly maps to the bottom two layers of the OSI model (Data Link and Physical)

The Internet Protocol Suite divides the layers in terms of the __scope of communications within each layer__ (within a local network, between networks, etc). The OSI model divides the layers in terms of the __functions that each layer provides__ (physical addressing, logical addressing and routing, encryption, compression, etc).

### What is encapsulation in the context of the layered system?
The layered system (regardless of which model is used) describes different aspects of the transmission of information. One important concept within these layered model is the encapsulation of data at each layer - data from one layer is generally paired with certain headers, which represent protocol-specific meta-information regarding that data (at the Link/Data Link layer, a trailer or footer may also be attached). This data and header is encapsulated into a __Protocol Data Unit__, which is then passed as a _data payload_ to the next, lower layer for further encapsulation. 

Data encapsulation has the benefit of abstracting away the protocol specific information and implementation details of a particular layer, when the Protocol Data Unit is passed to the next layer. This means that each individual layer is separate from the previous layer - a given layer does not need to know about the specific implementation details of a protocol at another layer - the given layer only needs to perform a specific function in the process of transmitting information, and does not need to change it's approach based on the protocols used at the 'upper' layer. This is particularly important when there might be many different protocols that could be used at a given layer (e.g. the Application layer, where the protocol could be HTTP for web browsers, SMTP for email clients, or FTP for file transfer applications).

### Describe the physical layer.
The 'physical' layer represents the transmission of information (in the form of bits) as a signal through a physical medium, such as electrical signals (copper wire), light signals (fibre optic cables) or radio waves (wireless transmission). It receives a Protocol Data Unit from the Link/Data Link layer above it and transmits this frame (in the case of the Ethernet protocol) as a signal to another device. Upon receiving this signal, the device (through it's Network Interface Card) is able to 'reconstruct' the frame as an Ethernet frame.

The OSI model defines a Physical layer as the bottommost layer of its model (Layer 1). The Internet Protocol Suite doesn't really concern itself directly with physical interfaces, though it does include some physical functions in the Link layer.

### Describe the characteristics of the physical layer.
As the physical layer involves the transmission of a signal across a physical medium, 'real world' laws of physics influence how this information is transported, such as how fast an electrical/light/radio signal can travel. There are two main physical characteristics which influence how information is transported in a physical sense:
- Latency, which is how __quickly__ data is transmitted from one point in a network to another.
- Bandwidth, which is how __much__ data can be transmitted from one point in a network to another in a given unit of time (e.g. one second)

There are four main types of latency (which all contribute to 'overall' latency) that we have to consider - we can think of these as the _delay_ in the time (usually measured in milliseconds) between transmitting information from the sender device and when the recipient device receives that information:
- _Propagation_ delay, which is simply the time taken for data to get from one point in the network to another. An analogy could be the speed limit on a road - a car simply cannot travel (legally) faster than this speed limit.
- _Transmission_ delay, which is the time taken to push the data onto a given device for transmission. This could be though of as a traffic light or intersection which a car must wait for before continuing it's journey onto another road.
- _Processing_ delay, which is the time taken for a given device to process the information it's given before it can begin transmitting the data. We can think of this as a checkpoint at a traffic light or intersection.
- _Queuing_ delay, which occurs when a network device is given more information that it can process at a given time; when this occurs, excess data that cannot be processed is sent to a buffer, until the network device is able to process it. This can be thought of traffic that a car has to wait in before it can be processed by the checkpoint in our analogy.

### What is the Round Trip Time (RTT)?
The Round Trip Time (RTT) is the time taken for a signal to be sent, combined with the time taken to receive an acknowledgment or response.

### What is the Link/Data Link Layer? What protocols does it use?
The Link/Data Link layer governs the transmission of information across different devices (or 'nodes') __within__ a local network.

Within the OSI model, the Data Link layer is Layer 2 and comes in between the Physical layer (1) and the Network layer (3). Within the Internet Protocol Suite, the Link layer is layer 1, since this model doesn't define a specific layer for the physical network. Within both of these models, the Link/Data-Link layer works as an _interface between the workings of the physical network and the more logical layers above_.

An example of a protocol used at this layer is the Ethernet protocol. This is a protocol that governs the physical infrastructure at this layer (e.g. how Ethernet cables should be physically constructed) as well as the transmission of information across devices within a network. Within this 'transmission of information' remit, there are two key functions that the Ethernet protocol provides:
- __Framing__, which specifies how the data that's sent to another network device should be structured, and the necessary meta-data to faciliate this. 
- __Addressing__, which specifies how to determine which network device should be sent information.

Framing, means attaching metadata via (frame headers) to the data payload that has been passed to the Link/Data Link layer by the Internet/Network layer, so that the data can be sent to the correct device (and that device can interpret the data). The Ethernet protocol governs what fields are required within the frame header and what size and sequence these fields should be in, providing a consistent structure to the data. Once these headers are attached, we have an Ethernet frame that can be passed down to the physical layer for transmission as a signal to another network device.

Addressing, in respect of the Ethernet protocol, typically relies on MAC (Media Access Control) addresses. Each network device has a unique, 'burned-in' address which can be used to identify it. We can think of these as a 'street' address. As a frame travels across different nodes in a network, the source and destination MAC address contained in the Ethernet frame header will change to reflect which device the frame has come from, and where it should go. An Ethernet frame will typically go through a switch within a network, which has a table of all the MAC addresses for devices that are connected to that switch. This table enables the frame to be sent to the correct device.

### What is the Internet/Network Layer? What protocols does it use?
The primary function of the Internet/Network layer is to facilitate communication _between hosts (e.g. computers) on different networks_.

In the OSI model the Network layer is layer 3 (between the Data Link and Transport layers). In the Internet Protocol Suite, the Internet layer is layer 2 (between the Link layer and the Transport layer). The Internet/Network layer primarily uses the Internet protocol as it's system of rules for data passed to and from this layer.  It covers:
- Routing capability (through use of IP addressing)
- Data encapsulation into 'packets' (the Protocol Data Unit at this layer)

The Internet Protocol can be thought of as 'end-to-end' - it only cares about the start and end points of communication, and not about how the data is routed through a given network. This is where IP addresses are useful - the source and destination IP addresses are captured in the Packet header. As the Internet Protocol is end to end, it solves the issue of MAC addresses not being hierarchical or logical (i.e. flat) - the specific value of the MAC address does not give an indication of what network that device lives across. Without IP addresses, any given router in a network would have to keep track of basically every single MAC address in existence in order to send the frame to the correct destination. 

IP addresses are __logical__ - they can be reassigned to different devices as necessary and can be split up into a hierarchy, or smaller networks (known as _sub-netting_). This allows routers (which direct traffic _between_ networks) to have necessary knowledge of a specific range of IP addresses (i.e. the devices within that local network) via it's local routing table, instead of having to retain a record of every single MAC address in existence. 

When the data from the Internet/Network layer has headers attached and sent as a packet to the Link/Data-Link layer, as the packet is encapsulated as a frame and sent between devices on a network, the frame must be decapsulated to determine what IP address the frame is supposed to end up at after all 'hops' through the network, and re-encapsulated as a frame to be passed onto the next network device so that can get the underlying packet to the correct final destination (each network device also has an IP address alongside it's MAC address). 

Since each router has a local routing table, which contains all the IP addresses of the devices it's connected to, it is able to verify whether the device the packet is ultimately intended for is connected to it (after frame decapsulation), and if not, re-encapsulate the data as a frame and forward the frame to another router which covers the relevant subnet for the destination IP address.

### What is DNS? What is it's function?
The DNS (Domain Name System) is a method through which a URL (Uniform Resource Locator) can be 'translated' to an IP address for routing across networks. When we type in a URL into our web browser, the web browser will send a request to DNS servers in order to 'translate' the domain name of the URL (i.e. the 'host') to an IP address. DNS servers operate in a hierarchical organisation - no single DNS server can contain every single IP address corresponding to a domain name.

If a DNS server does not contain a requested domain name, the DNS server routes the request to another DNS server up the hierarchy. Eventually, the address will be found in the DNS database on a particular DNS server, and the corresponding IP address will be used to receive the request. This IP address is then captured in the destination IP address header, and attached to the segment/datagram data payload that was passed to the Internet/Network layer for encapsulation as a packet, and passed to the Link/Data Link layer.

### What is the transport layer?
The Internet/Network layer is responsible for the transmission of information across different networks. However, this can prove problematic if we have multiple applications that want to send data to a server over a single connection. 

The transport layer is the series of processes that is responsible for transmitting (potentially multiple) Protocol Data Unit(s) from the application layer to the Internet/Network layer - i.e. multiplexing potentially numerous sources of Application layer PDUs on a client machine over a single communication channel to the server through the use of network ports (defined as an identifier for a specific process) that is included in the header. 

In the OSI model, the Transport layer is a layer between the Presentation and Network layers. In the Internet Protocol Suite, the Transport layer is layer 3 (between the Application and Internet layer), which combines parts of the Session and Transport layer in the OSI model. The Transport layer typically uses either the Transmission Control Protocol (TCP) or the User Datagram Protocol (UDP), depending on the use-case required/defined by the application, to structure the data for encapsulation, ready to be passed to the Internet layer.

### What is multiplexing? Why is it necessary?
Multiplexing is a property that enables multiple, different types of application data to be transmitted across a single connection. In a 'layered' system like OSI or the Internet Protocol Suite, it can exist at the physical layer (e.g. an optical fibre that carries multiple light signals using different angles of refraction, or radio waves being transmitted on different frequencies), but is particularly prevalent at the transport layer, where different applications can establish dedicated virtual connections over a single communication channel with a server, through the use of network ports over a single IP address. Demultiplexing is the opposite of this  - separating different types of application data being sent over a single connection, such that the server can respond with the relevant information according to the different application requests.

### What is a port? What is it used for?
A port is an identifier for a specific application process. It is a means of enabling multiplexing on the transport layer - different applications on the _client_ machine will be assigned different port numbers (generally randomly chosen ephemeral ports between 1024-65535, depending on the operating system), while the server will typically use well-established ports by convention (e.g. HTTP requests are generally sent to port 80 on a server).

The benefit of using ports is that different applications are able to simultaneously send data over a single communication channel to a server (when combined with an IP address at the Internet/Network layer) - this is known as multiplexing. Demultiplexing is the opposite - the ability of the server to interpret different application layer PDUs and respond with the appropriate response data to the appropriate port on the client machine. The PDU on the transport layer will include the source and destination port in the header to assist in this 'interpretation' and correct delivery.

### What is a socket? What is it used for?
At a conceptual level, a 'socket' is a combination of the IP address and port of a machine. A socket enables multiplexing over a single communication channel, since the application data can be sent to an appropriate port on the server, and the server is able to interpret and distinguish between the different application data requests, and serve the relevant data back to the client. Sockets can be regarded as __communication end-points__. This definition should be distinguished from sockets at an implementation level (e.g. UNIX sockets).

### What is a connection-oriented network system? What is an example of this?
A connection-oriented network system is one that instantiates different socket objects on the server side, such that each application on the client-side will have a dedicated virtual connection on the server machine through the use of sockets (the combination of an IP address and port number) and enables demultiplexing capabilities on the server side. Each PDU sent to the server will have a source and destination IP, as well as a source and destination port number (known as a _four-tuple_). This provides the potential for __reliable__ connections, by enabling capabilities like in-order delivery, acknowledgments of received messages and retransmission of messages that weren't received, since a _connection must be established before data can be transferred_. The Transmission Control Protocol (TCP) at the Transport layer is an example of a protocol that is connection-oriented.

### What is a connectionless network system? What is an example of this?
A connectionless network system is one that __does not__ instantiate multiple socket objects on the server side for each source of application data - a single socket object will handle all requests, and simply respond to them in the order as and when they arrive at the server. An example of a connectionless protocol is the User Datagram Protocol (UDP). It's important to note that connectionless systems _still provide multiplexing capabilities_ (i.e. multiple different sources of application data can be transmitted over a single communication channel between client and server) - a connectionless system will not have the capability to provide for reliability related functionality.

### What is network reliability? How do we achieve network reliability?
The layers below the transport layer are _unreliable_ - they do not provide for retransmission of lost data. In the case of the Internet/Network and Link/Data-Link layers, the PDUs can have checksums in their headers which can indicate whether the PDU has become corrupted during transmission. However, in the case of corruption, these PDUs are simply dropped. It is incumbent on the transport layer to provide reliability mechanisms.

Network reliability in this context can relate to four different aspects:
1. In-order delivery - messages are typically broken up into multiple pieces for transmission; in-order delivery means that the messages are received in the order they are sent so that the overall PDU can be reconstructed correctly by the server.
2. Error detection - Using a checksum in the header, corruption in the data can be identified. While other layers do provide error detection, this is important in the context of IPv6 in the Internet/Network layer, which no longer has a checksum header field. 
3. Handling data loss - Missing or corrupted messages are detected through the sequence numbers in the PDU header, acknowledgement messages and timeouts, and retransmitted.
4. Handling duplication - The sequence number in the PDU header can identify duplicate messages and disregarded.

### What is TCP? What are it's downsides/upsides? *
TCP (Transmission Control Protocol) is a connection-oriented protocol used at the Transport layer. As it is connection-oriented, it provides for reliability mechanisms, such as in-order delivery, error detection, handling data loss and data duplication. It also involves individual socket objects being instantiated on the server machine for each distinct type of application data sent by the client.

Two key roles that TCP provides are:
1. Reliability, through the TCP Handshake and fields within the header
2. Encapsulation of the data payload, with headers, to create a TCP segment (which is passed to the Network/Internet layer).

Part of the reliability of TCP comes from the TCP handshake. This is a process that theoretically must occur before each request as part of establishing a connection between two hosts (though in practice, `keep-alives` and `pipelining` is used to reduce the connection overhead by allowing a particular connection to handle multiple requests). In short:
1. The sender sends an empty TCP segment, with the `SYN` flag set to `1`. This is the signal that the sender wishes to establish a connection. 
2. The recipient receives the `SYN` message, and responds with a `SYN ACK` message (again, an empty message with the `SYN` and `ACK` flags set to `1`), acknowledging that it received the `SYN` message. 
3. The sender then sends an `ACK` message, acknowledging the receipt of the `SYN ACK` message. At this point, the sender is able to start sending data to the recipient. 
4. The recipient receives the `ACK` message. At this point, the receiver can send data back to the sender.

The _headers_ in the TCP segment also provide for another element of reliability; in particular the `sequence` and `acknowledgment` numbers, which enable in-order delivery, handling data loss and duplication.  

The TCP handshake process establishes a TCP connection, and enables data transmission. As there is additional latency involved with establishing a TCP connection, TCP provides two additional mechanisms to facilitate efficient data transfer (i.e. minimising the amount of data that needs to be retransmitted); _flow control_ and _congestion avoidance_.

__Flow control__ is a mechanism to avoid the sender overwhelming the receiver with more data than it can process. The receiver only has a certain amount of bandwidth it can use to process data over a given period of time. Data that is sent to the receiver but awaiting processing is stored in a buffer (the size of the buffer depends on the operating system and physical resources available). Flow control can be implemented through the `window` header in a TCP segment - this indicates the amount of data both the sender and receiver are willing to accept. If the receiver's buffer is filling up, it can send an acknowledgement message with a smaller `window` size to indicate the sender needs to reduce the amount of data it is sending. 

__Congestion avoidance__ occurs when there is more data being transmitted across the network than the network capacity will allow. At the Network/Internet layer, routers are responsible for transmitting data across networks. Routers typically can only process a certain amount of data at a time - excess data is stored in a abuffer, awaiting processing. However, if the router is receiving more data than can fit in the buffer, excess data is simply dropped. 

As TCP provides for data retransmission, it can detect if a large amount of data is being retransmitted across the network (network congestion is likely occurring). To combat this, TCP can adjust the `window` size in the TCP segment header to reduce the amount of data being transferred.

Two downsides associated with TCP are:
1. TCP handshakes adding overhead to data transfer - additional latency must occur before any application data can be sent. 
2. Head of Line (HOL) blocking - as TCP allows for in-order delivery, if a particular part of a message is corrupted/lost and needs to be retransmitted, this will block the delivery and processing of subsequent messages. While HOL blocking isn't unique to TCP, retransmission still increases the queuing delay, which contributes to overall latency.
### What is UDP? What are it's downsides/upsides?
UDP (User Datagram Protocol) is a connectionless protocol used in the Transport layer. It provides multiplexing capability for application data - i.e. it enables different applications to send data or requests to the server over a single communication channel, through the use of source ports. However, as UDP is a connectionless protocol, on the server side, only a single socket object is instantiated, meaning all of the UDP datagrams travel to the same socket. This has the effect of the server processing requests as and when they come.

UDP datagram headers are much simpler - they have
1. Source Port
2. Destination Port
3. Length
4. Checksum

The fact that there are much fewer header fields than with TCP indicates that UDP is much more limited in respect of the reliability capabilities than TCP. At it's heart, UDP __doesn't do anything to resolve the unreliability of protocols__ in the layers beneath it. UDP __does not__ provide for in-order delivery, retransmission of data or the state of a connection - as it is connectionless, an application can simply start sending data _without having to wait for a connection to be established_ with the application process of the receiver. 

The upside of UDP (compared to TCP) is that there is much less overhead and latency when it comes to sending data - no handshake process is required, fewer headers need to be populated, and no acknowledgement messages or retransmission mean the data delivery is faster. Since there is no in-order delivery, Head of Line blocking isn't an issue at the Transport layer.

The fact that UDP is much more bare bones grants it flexibility - an application may require one aspect of reliability but not require others - e.g. in-order delivery may be relevant, but not retransmission or duplication. An application developer can simply build additional services on top of UDP, rather than deal with the additional complexities within TCP.

### What is the TCP handshake?

### What is pipelining?

### What is flow control?

### What is congestion avoidance?
