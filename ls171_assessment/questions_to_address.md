### What is the internet?
The internet can be described as a _network of networks_ - it allows for the communication between devices and the transfer of information across different networks.The _world wide web_ or web for short, is a __service__ that can be accessed via the internet.

### What is a network?
A network, at it's simplest implementation, is two devices connected in such a way that they are able to communicate or exchange data between themselves. The key is that communications are limited to devices that exist within the same network (the Local Access Network, or LAN) and are connected to each other (either directly, or through a switch or hub).

Communication within a network is handled by the Link/Data Link layer, which establishes protocols that enable the devices that are connected to each other on the LAN to communicate to each other through a protocol. An example protocol at the Link/Data Link Layer is the Ethernet Protcol, which incorporates both physical hardware specifications (e.g. how an CAT6 cable should be constructed) and logical transmission of information, through __addressing__ (determining which device to send information to) and __framing__ (structuring the information to be transmitted so that the other device is able to interpret it).

### What is a protocol?
Fundamentally, protocols are a _system of rules that govern the exchange or transmission of data_. Protocols exist across:
- _Different_ aspects of communication, e.g. across different functions of network communication, such as transmission of information __between__ networks (e.g. the Internet Protocol on the Internet/Network Layer) and transmission __within__ a network (e.g. the Ethernet Protocol in the Link/Data Link layer); and
- The _same_ aspect of communication, but have different functionalities depending on the use case (e.g. TCP or UDP on the Transport layer).

### Explain the 'layered system'
The layered system is a mental model that we can adopt to group different aspects of communication. Protocols (depending on the layered system used) can be thought of as operating at a single, particular 'layer', to represent the system of rules for transmitting information at a particular step of the communication process.

There are two popular 'layered' network communication models that describe the communication process; the OSI (Open Systems Interconnection) model, and the Internet Protocol Suite (IPS). They are roughly equivalent (though some overlap does occur) in respect of the 'layers' that they describe:
- The top layer of the IPS (Application) mostly maps to the top three layers of the OSI Model (Application, Presentation, Session).
- The second layer of the IPS (Transport) mostly maps to the fourth layer of the OSI model (Transport)
- The third layer of the IPS (Internet) mostly maps to the fifth layer of the OSI model (Network)
- The fourth layer of the IPS (Link) mostly maps to the bottom two layers of the OSI model (Data Link and Physical)

The Internet Protocol Suite divides the layers in terms of the __scope__ of communications (e.g. within a local network, between networks, etc). The OSI model divides the layers in terms of the __functions__ that each layer provides (physical addressing, logical addressing and routing, encryption, compression, etc).

### What is encapsulation in the context of the layered system?
The layered system (regardless of which model is used) describes different aspects of the transmission of information. One important concept within these layered models is the encapsulation of data at each layer. Data (the data payload) from one layer is generally paired with certain headers, which represent protocol-specific meta-information regarding that data (at the Link/Data Link layer, a trailer or footer may also be attached). This data and header is encapsulated into a __Protocol Data Unit__, which is then passed as a _data payload_ to the next, lower layer for further encapsulation. 

Data encapsulation has the benefit of abstracting away the protocol specific information and implementation details of a particular layer, when the Protocol Data Unit from the previous layer is passed to the next, lower layer. This means that the given layer only needs to perform a specific function in the process of transmitting information, and does not need to change it's approach based on the protocols used at the 'upper' layers. This is particularly important when there might be many different protocols that could be used at a given layer (e.g. the Application layer, where the protocol could be HTTP for web browsers, SMTP for email clients, or FTP for file transfer applications).

### Describe the physical layer.
The 'physical' layer represents the transmission of information (in the form of bits) as a signal through a physical medium, such as electrical signals (copper wire), light signals (fibre optic cables) or radio waves (wireless transmission). It receives a Protocol Data Unit from the Link/Data Link layer above it and transmits this frame (in the case of the Ethernet protocol) as a signal to another device. Upon receiving this signal, the receiving device (through it's Network Interface Card) is able to 'reconstruct' the signal as an Ethernet frame, allowing the receiving device to decapsulate the frame and pass the relevant information 'up' through the different layers to the application.

The OSI model defines a Physical layer as the bottommost layer of its model (Layer 1). The Internet Protocol Suite doesn't really concern itself directly with physical interfaces, though it does include some physical functions in the Link layer.

### Describe the characteristics of the physical layer.
As the physical layer involves the transmission of a signal across a physical medium, 'real world' laws of physics influence how this information is transported, such as how fast an electrical/light/radio signal can travel. There are two main physical characteristics which influence how information is transported in a physical sense:
- Latency, which is how __quickly__ data is transmitted from one point in a network to another.
- Bandwidth, which is how __much__ data can be transmitted from one point in a network to another in a given unit of time (e.g. one second)

There are four main types of latency (which all contribute to 'overall' latency) that we have to consider - we can think of these as the _delay_ (usually measured in milliseconds) between transmitting information from the sender device and when the recipient device receives that information:
- _Propagation_ delay, which is simply the time taken for data to get from one point in the network to another. An analogy could be the speed limit on a road - a car simply cannot travel (legally) faster than this speed limit.
- _Transmission_ delay, which is the time taken to push the data onto a given device for transmission. This could be thought of as a traffic light or intersection which a car must wait for before continuing it's journey onto another road.
- _Processing_ delay, which is the time taken for a given device to process the information it's received before it can begin transmitting the data elsewhere. We can think of this as the time spent a checkpoint before a traffic light or intersection.
- _Queuing_ delay, which occurs when a network device is given more information that it can process at a given time; when this occurs, excess data that cannot be processed is sent to a buffer, until the network device is able to process it. This can be thought of traffic that a car has to wait in before it can be processed by the checkpoint in our analogy.

### What is the Round Trip Time (RTT)?
The Round Trip Time (RTT) is the time taken for a signal to be sent, combined with the time taken to receive an acknowledgment or response.

### What is the Link/Data Link Layer? What protocols does it use?
The Link/Data Link layer concerns the transmission of information across different devices (or 'nodes') __within__ a local network.

Within the OSI model, the Data Link layer is Layer 2 and comes in between the Physical layer (1) and the Network layer (3). Within the Internet Protocol Suite, the Link layer is layer 1, since this model doesn't define a specific layer for the physical network. Within both of these models, the Link/Data-Link layer works as an _interface between the workings of the physical network and the more logical layers above_.

An example of a protocol used at this layer is the Ethernet protocol. This is a protocol that governs the physical infrastructure at this layer (e.g. how Ethernet cables should be physically constructed) as well as the transmission of information (and how it should be structured) across devices within a network. There are two key functions that the Ethernet protocol provides:
- __Framing__, which specifies how the data that's sent to another network device should be structured, and the necessary meta-data to faciliate this and help the receiving device interpret the data payload. 
- __Addressing__, which specifies how to determine which network device should be sent information.

Framing, means attaching metadata via frame headers to the data payload that has been passed to the Link/Data Link layer by the Internet/Network layer, so that the data can be sent to the correct device (and that device can interpret the data) on the local network. The Ethernet protocol governs what fields are required within the frame header and what size and sequence these fields should be in, providing a consistent structure to the data. Once these headers are attached to the data payload, we have an Ethernet frame that can be passed down to the physical layer for transmission as a signal to another network device.

Addressing, relates to where a frame should be sent within the local network. In respect of the Ethernet protocol, this is achieved through MAC (Media Access Control) addresses. Each network device has a unique, 'burned-in' address which can be used to identify it. As a frame travels across different nodes in a network, the source and destination MAC address contained in the Ethernet frame header will change to reflect which device the frame has come from, and where it should go, respectively. An Ethernet frame will typically go through a switch within a network, which has a table of all the MAC addresses for devices that are connected to that switch. This table enables the frame to be correctly sent to the intended device.

### What is the Internet/Network Layer? What protocols does it use?
The primary function of the Internet/Network layer is to facilitate communication _between hosts (e.g. computers) on different networks_.

In the OSI model the Network layer is layer 3 (between the Data Link and Transport layers). In the Internet Protocol Suite, the Internet layer is layer 2 (between the Link layer and the Transport layer). The Internet/Network layer primarily uses the Internet protocol as it's system of rules for data passed to and from this layer.  It covers:
- Routing capability (through use of IP addressing)
- Data encapsulation into 'packets' (the Protocol Data Unit at this layer)

The Internet Protocol can be thought of as 'end-to-end' - it only cares about the start and end points of communication, and not about _how_ the data is routed through a given network (or even between networks via routers). This is where IP addresses are useful - the source and destination IP addresses are captured in the Packet header. MAC addresses are not hierarchical or logical (i.e. flat) - the specific value of the MAC address does not give an indication of what network that device lives in. Without IP addresses, any given router in a network would have to keep track of basically every single MAC address in existence in order to send the frame to the correct destination. 

As IP addresses are __logical__, they can be reassigned to different devices as necessary and can be split up into a hierarchy of smaller networks (known as _sub-netting_). This allows routers (which direct traffic _between_ networks) to only have knowledge of a specific range of IP addresses (i.e. for the devices within that local network) that they cover via the router's local routing table, instead of having to retain a record of every single MAC address in existence. 

When the data from the Internet/Network layer has headers attached and sent as a packet to the Link/Data-Link layer, as the packet is encapsulated as a frame and sent between devices on a network, the frame must be decapsulated to determine what IP address the frame is supposed to end up at after all 'hops' through the network, and re-encapsulated as a frame to be passed onto the next network device so that can get the underlying packet to the correct final destination (each network device also has an IP address alongside it's MAC address). 

Since each router has a local routing table, which contains all the IP addresses of the devices it's connected to, it is able to verify whether the device the packet is ultimately intended for is connected to it (after frame decapsulation), and if not, re-encapsulate the data as a frame and forward the frame to another router which covers the relevant subnet for the destination IP address.

### What is DNS? What is it's function?
The DNS (Domain Name System) is a method through which a URL (Uniform Resource Locator) can be 'translated' to an IP address for routing across networks. When we type in a URL into our web browser, the web browser will send a request to DNS servers in order to 'translate' the domain name of the URL (i.e. the 'host' component of the URL) to an IP address. DNS servers operate in a hierarchical organisation - no single DNS server can contain every single IP address corresponding to a domain name.

If a DNS server does not contain a requested domain name, the DNS server routes the request to another DNS server higher up in the DNS hierarchy. Eventually, the address will be found in the DNS database on a particular DNS server, and the corresponding IP address will be used as the 'address' to receive the request. This IP address is captured in the destination IP address header, and attached to the segment/datagram data payload that was passed to the Internet/Network layer from the Transport layer for encapsulation as a _packet_, and passed to the Link/Data Link layer.

### What is the transport layer?
The Internet/Network layer is responsible for the transmission of information across different networks (socket-to-socket). However, this can prove problematic if we have multiple applications that want to send data to a server over a single connection. 

The transport layer governs the transmition of (potentially multiple) Protocol Data Unit(s) from the application layer to the Internet/Network layer - i.e. multiplexing potentially numerous sources of Application layer PDUs on a client machine over a single communication channel to the server through the use of network ports (defined as an identifier for a specific process) that is included in the header. 

In the OSI model, the Transport layer is a layer between the Presentation and Network layers. In the Internet Protocol Suite, the Transport layer is layer 3 (between the Application and Internet layer), which combines parts of the Session and Transport layer in the OSI model. The Transport layer typically uses either the Transmission Control Protocol (TCP) or the User Datagram Protocol (UDP), depending on the use-case required by the application, to structure the data for encapsulation, ready to be passed to the Internet layer.

### What is multiplexing? Why is it necessary?
In the context of the Transport layer, multiplexing is a property that enables multiple, different types of application data to be transmitted across a single connection. In a 'layered' system like OSI or the Internet Protocol Suite, it can exist at the physical layer (e.g. an optical fibre that carries multiple light signals using different angles of refraction, or radio waves being transmitted on different frequencies), but is particularly prevalent at the transport layer, where different applications can establish dedicated virtual connections over a single communication channel with a server, through the use of network ports over a single IP address. Demultiplexing is the opposite of this - separating and differentiating between multiple types of application data being sent over a single connection, such that the server can respond with the relevant information to the correct application.

### What is a port? What is it used for?
A port is an _identifier for a specific application process_. It is a means of enabling multiplexing on the transport layer - different applications on the _client_ machine will typically be assigned different port numbers (generally randomly chosen ephemeral ports between 1024-65535, depending on the operating system), while the server will typically use well-established ports by convention (e.g. HTTP requests are generally sent to port 80 on a server).

The benefit of using ports is that different applications are able to simultaneously send distinct 'streams' of data over a single communication channel to a server (when combined with an IP address at the Internet/Network layer, known as a _socket_) - this is known as multiplexing. Demultiplexing is the opposite - the ability of the server to interpret different application layer PDUs and respond with the appropriate response data to the appropriate port on the client machine. The PDU on the transport layer will include the source and destination port in the header to assist in this 'interpretation' and correct delivery.

### What is a socket? What is it used for?
At a conceptual level, a 'socket' is a combination of the IP address and port of a machine. A socket enables multiplexing over a single communication channel, since the application data can be sent to an appropriate port on the server, and the server is able to interpret and distinguish between the different application data requests, and serve the relevant data back to the client. Sockets can be regarded as __communication end-points__. This definition should be distinguished from sockets at an implementation level (e.g. UNIX sockets).

### What is a connection-oriented network system? What is an example of this?
A connection-oriented network system is one that instantiates different socket objects on the server side, such that each application on the client-side will have a dedicated virtual connection on the server machine through the use of sockets (the combination of an IP address and port number) - a connection must first be established. 

Each PDU sent to the server will have a source and destination IP, as well as a source and destination port number (known as a _four-tuple_). This provides the potential for __reliable__ connections, by enabling capabilities like in-order delivery, acknowledgments of received messages and retransmission of messages that weren't received. The Transmission Control Protocol (TCP) at the Transport layer is an example of a protocol that is connection-oriented.

### What is a connectionless network system? What is an example of this?
A connectionless network system is one that __does not__ instantiate multiple socket objects on the server side for each source of application data - a single socket object will handle all requests, and simply respond to them in the order as and when they arrive at the server; no connection acknowledgment exists. 

An example of a connectionless protocol is the User Datagram Protocol (UDP). It's important to note that connectionless systems _still provide multiplexing capabilities_ (i.e. multiple different sources of application data can be transmitted over a single communication channel between client and server); however, a connectionless system will generally not have the capability to provide for reliability related functionality like a connection-oriented network system would.

### What is network reliability? How do we achieve network reliability?
The layers below the transport layer are _unreliable_ - they do not provide for retransmission of lost data. In the case of the Internet/Network and Link/Data-Link layers, the PDUs can have checksums in their headers which can indicate whether the PDU has become corrupted during transmission. However, in the case of corruption, these PDUs are simply dropped. It is incumbent on the transport layer to provide reliability mechanisms.

Network reliability in this context can relate to four different aspects:
1. In-order delivery - messages are typically broken up into multiple pieces for transmission; in-order delivery means that the messages are received and processed in the order they are sent so that the overall PDU can be reconstructed correctly by the server.
2. Error detection - Using a checksum in the header, corruption in the data can be identified. While other layers do provide error detection, this is important in the context of IPv6 in the Internet/Network layer, which no longer has a checksum header field. 
3. Handling data loss - Missing or corrupted messages are detected through the sequence numbers in the PDU header, acknowledgement messages and timeouts. These lost or corrupt messages are retransmitted.
4. Handling duplication - The sequence number in the PDU header can identify duplicate messages, which are disregarded.

### What is TCP? What are it's downsides/upsides? *
TCP (Transmission Control Protocol) is a connection-oriented protocol used at the Transport layer. As it is connection-oriented, it provides for reliability mechanisms, such as in-order delivery, error detection, handling data loss and data duplication. It also involves individual socket objects being instantiated on the server machine for each distinct type of application data sent by the client.

Two key roles that TCP provides are:
1. Encapsulation of the data payload, with headers, to create a TCP segment (which is passed to the Network/Internet layer). 
2. Reliability, through the TCP Handshake, acknowledgments to each message sent and fields within the header

In respect of encapsulation, TCP provides for a number of headers which contribute to multiplexing (i.e. the source and destination ports), reliability (sequence and acknowledgment number headers) and improving bandwidth utilisation/reducing network congestion (i.e. the window size field).

In respect of reliability, part of the reliability of TCP comes from the TCP handshake. The TCP handshake process establishes a TCP connection, and enables data transmission. This is a process that theoretically must occur before each request as part of establishing a connection between two hosts (though in practice, `keep-alives` and `pipelining` is used to reduce the connection overhead by allowing a particular connection to handle multiple requests). In short:
1. The sender sends an empty TCP segment, with the `SYN` flag set to `1`. This is the signal that the sender wishes to establish a connection. 
2. The recipient receives the `SYN` message, and responds with a `SYN ACK` message (again, an empty message with the `SYN` and `ACK` flags set to `1`), acknowledging that it received the `SYN` message. 
3. The sender then sends an `ACK` message, acknowledging the receipt of the `SYN ACK` message. At this point, the sender is able to start sending data to the recipient. 
4. The recipient receives the `ACK` message. At this point, the receiver can send data back to the sender.

With TCP, each message sent to the receiver has an accompanying acknowledgment message, notifying the sender that the message has been received by the receiver. This is part of the reliability built into TCP, and can handle a number of 'error' states:
1. If an acknowledgment message is not received by the sender (after sending a message) within a certain timeframe, the TCP connection will re-transmit that message.
2. If the receiver's acknowledgment message did not get through to the sender, but did in fact receive the original message, the receiver is able to handle duplicate messages (identified through the sequence number in the header) when the sender re-transmits the same message - the receiver will discard the duplicate message and attempt to send another acknowledgment for that particular message.

Two downsides associated with TCP are:
1. TCP handshakes adding overhead to data transfer - a TCP connection must be established before any application data can be sent. 
2. The process of having to send acknowledgments for messages adds latency, meaning that overall data delivery is slower than Transport layer protocols like UDP, which by default don't provide for this capability.
3. Head of Line (HOL) blocking - as TCP allows for in-order delivery, if a particular part of a message is corrupted/lost and needs to be retransmitted, this will block the delivery and processing of subsequent messages. While HOL blocking isn't unique to TCP, retransmission still increases the queuing delay, which contributes to overall latency.

### What is UDP? What are it's downsides/upsides?
UDP (User Datagram Protocol) is a connectionless protocol used in the Transport layer. It provides multiplexing capability for application data - i.e. it enables different applications to send data or requests to the server over a single communication channel, through the use of source ports. However, as UDP is a connectionless protocol, on the server side, only a single socket object is instantiated, meaning all of the UDP datagrams travel to the same socket. This has the effect of the server processing requests as and when they come.

UDP datagram headers are much simpler - they have the following fields:
1. Source Port
2. Destination Port
3. Length
4. Checksum

The fact that there are much fewer header fields in a datagram than a TCP segment indicates that UDP is much more limited in respect of the reliability capabilities than TCP. UDP __doesn't do anything to resolve the unreliability of protocols__ in the layers beneath it. UDP __does not__ provide for in-order delivery, retransmission of data or the state of a connection - as it is connectionless, an application can simply start sending data _without having to wait for a connection to be established_ with the application process of the receiver. 

The upside of UDP (compared to TCP) is that there is much less overhead and latency when it comes to sending data - no handshake process is required, fewer headers need to be populated, and no acknowledgement messages or retransmission mean the data delivery is faster. Since there is no in-order delivery, Head of Line blocking isn't an issue at the Transport layer when using UDP.

The fact that UDP is much more bare bones grants it flexibility - an application may require one aspect of reliability but not require others - e.g. in-order delivery may be relevant, but not retransmission or duplication. An application developer can simply build additional services on top of UDP, rather than deal with the additional complexities within TCP.

### What is the TCP handshake?
The TCP handshake is a process of establishing a TCP connection between a client and a server that needs to occur (in theory) prior to each request. The process is:
1. The sender sends an empty TCP segment (i.e. without a data payload), with the `SYN` flag set to `1`.
2. The receiver receives the `SYN` message, and sends an empty TCP segment with the `SYN ACK` flags set to `1`.
3. The sender receives the `SYN ACK` flag, and sends an empty message with the `ACK` flag set to `1`. After sending this `ACK` message, the sender is able to start transmitting data to the receiver. 
4. Once the receiver receives the `ACK` message, it is able to send data back to the sender.

The TCP handshake, in reality, might occur less frequently than with each request. Connection types like `keep-alives` or pipelining exist to 're-use' a TCP connection for multiple requests. While it provides for an aspect of reliability (i.e. ensuring a live connection is established before sending data), the additional sending of messages contributes to latency, since messages cannot be sent until this handshake is complete.

### What is pipelining?
In theory, the TCP handshake must occur prior to every request being made (i.e. establish a TCP connection). This would slow down the message delivery process, since additional latency is increased through waiting for the messages in the TCP handshake to send, and is generally an inefficient process - only a single message can be sent at a time, and much of the time is spent waiting for an acknowledgment.

Pipelining is a way to reduce this connection overhead by sending multiple requests at a time over a single TCP connection (i.e. some 'persistence' is introduced to the TCP connection). The number of messages depends on the value set in the `window size` field in the TCP segment header. Pipelining does _not_ impact reliability, since each message still receives an acknowledgment, and retransmission can occur. It improves bandwidth utilisation, since more requests are being transferred over the connection for a given unit of time.

### What is flow control?
Flow control is a way that TCP can avoid the recipient of messages from being overwhelmed by too much data (i.e. more than it can process) at a particular point in time. A receiver typically has a maximum capacity for processing data; data in excess of this processing capacity will be stored in a buffer (whose size depends on the operating system and physical resources), to be processed when the receiver has the capacity to do so. However, when this buffer is full, additional data is not added to the buffer - it is simply dropped. 

While TCP does provide for retransmission, retransmission adds to latency, both through introducing additional round trips to the transmission process, but also potentially introducing queuing delay through additional Head-of-Line blocking if subsequent messages need prior messages to be resent and processed. To reduce the likelihood of this occuring, the receiver, in it's acknowledgment messages, is able to change the value in the `window size` header field, to indicate to the sender it is being overwhelmed by the amount of data being sent to it. As a result, the sender will reduce the amount of requests sent per connection, to allow the receiver to 'catch-up'.

### What is congestion avoidance?
Congestion avoidance is the ability of TCP to identify whether the amount of data transferred from sender to receiver is overwhelming the underlying network. Layers beneath the transport layer do not have reliability functionality like the Transport layer can have. When data is sent to a router (the Internet/Network layer), the router is able to store data it does not have capacity to process in a buffer. However, if that buffer becomes full, excess data is simply dropped. 

TCP is responsible for monitoring and re-transmission of the lost data. Re-transmission of data is inefficient and increases the overall latency of data transmission. If the amount of re-transmission becomes excessive, TCP is able to reduce the value in the `window size` header field, which reduces the amount of requests sent on a given TCP connection. This enables the routers on the Internet/Network layer to 'catch-up' and process the data in their buffers, reducing the amount of re-transmission required.

### What is the application layer?
The application layer is the top layer in both the OSI and Internet Protocol Suite network models. The protocols at the application layer vary according to the underlying application that is trying to transmit data; the common theme is that the various protocols are responsible for _providing communication services_ to these underlying applications, and _structuring the application data_ (and what data is should contain) for transmission, so that they can be encapsulated for lower levels and _interpreted by other application services_.

### What is HTTP?
HTTP (HyperText Transfer Protocol) is a protocol used at the application layer to provide _uniformity to how resources are transferred between applications_ (i.e. __message format__). It is a text-based protocol that follows a request-response model; a client will make a request to a server, and wait for the server to response, though it is the TCP and IP protocols that are involves in the actual transfer.

### What is a URL? How is it different from a URI? *
A URL (Uniform Resource Locator) is a subset of a URI (Uniform Resource Identifier). Per RFC3986, a URI is a sequence of characters that identifies an abstract or physical resource, while a URL is a URI that provides a _means of locating that resource_ by describing it's primary access mechanism (i.e. the network address), while a URI does __not__ provide the specific protocol or directory path required to access the underlying resource.

In the context of a web browser, when a user types a URL in the address bar, the browser will usually make a DNS request to translate the URL to an IP address so that the data can be transferred to the correct server.

### What are the components of a URL? *
A URL has five potential components:
1. The __scheme__: This is identified by the characters prior to the `://` sequence of characters in a URL. It specifies the client _how to access the resource_, usually by specifying the protocol required. Examples include `http`, `ftp` or `mailto`.
2. The __host__: This part of the URL specifies __where__ the client can find the resource - e.g. `www.google.com`
3. The __port__: This is only explicitly specified if we want to use a non-default port when the request is made (otherwise the browser will use the default port number, which is 80 for `http`, and 443 for `https`). Otherwise, it's assumed to be part of every URL.
4. The __path__: This is a more specific reference to a resource and is optional - e.g. `/home/`
5. The __query string__: These are name-value pairs that can be used as part of a `GET` request to send specific information to the server, and is optional - e.g. `?product=phones`

### What is a query string parameter? Why would we use it/not use it?
A query string parameter is an optional field in a URL that can be used to communicate specific information when making a `GET` request to a server. They take the form of name value pairs. They can be identified as the name-values pairs in a URL following the `?` character (e.g. `?product=phone`). The `name` is the series of characters to the left of the `=` symbol, while the value is the string to the right of the `=` symbol. Different name-value pairs are separated by the `&` character (e.g. `?product=phone&colour=white`).

Query string parameters have some limitations. 
- As HTTP is a text-based protocol, it's not recommended to use query string parameters when sensitive information is being sent to the server (such as username, passwords, or potentially personally identifiable information), as the query string parameters are visible in the URL, and could be intercepted by a third party. 
- Query string parameters also have a maximum length - if there is a significant amount of data that needs to be passed to the server, this may not fit within the URL.
- Certain characters, such as `&` or `=` (e.g. characters that aren't in the standard 128-character ASCII character set, or are reserved to identify the query string parameters themselves) cannot be used in a query string (they must be encoded).

If we are sending potentially sensitive information to a server, and/or a lot of data, it's recommended to use a `POST` request instead.

### What is URL encoding and why would we use it?
URL encoding is the process of replacing certain characters in a URL, where those characters aren't in the standard 128-character ASCII character set, or are otherwise reserved or unsafe (i.e. being used in a fashion different to a specific intended purpose, such as identifying query parameters). URL encoding typically replaces these offending characters with a `%` symbol, followed by two hexadecimal digits that represent the ASCII code of the chracter.
- An _unsafe_ character is one that may be misinterpreted or potentially modified by some systems - e.g. `%` is used as part of the URL encoding process, and could be misinterpreted as being used for that purpose. 
- A _reserved_ character is one that is reserved for a specific purpose in the URL scheme - e.g. `?` is used to denote the start of a query string.

### What is a server? What are the infrastructure components of a server?
A server is simply a machine that is designed to listen for incoming requests, and provide data in response to those requests. A server will typically comprise of three distinct pieces of infrastructure (though these infrastructure pieces may be distributed across many different machines):
1. Web server: This is a server designed to respond to requests for static assets, like images, HTML, CSS or JavaScript files, which don't require business logic or complex processing to provide a response.
2. Application server: This is a server designed to provide data that requires some degree of processing or business logic (this is where server-side code exists when deployed).
3. Data Store: This is infrastructure that is designed to act as a persistent data store (e.g. a relational database), where data can be retrieved or created.

### What are resources?
Resources is a generic term for anything we might interact with on the internet with a URL. Examples include images, videos, HTML files, or even applications themselves.

### What is statelessness? Why is it an issue with HTTP?
Statelessness in the context of a protocol means that each request/response pair is independent of another - request/response pairs have no context or knowledge of the data transmitted in other request/response pairs. This is helpful for HTTP, in that information _does not need to be persisted between requests_, and if a request is not successful, there is no clean-up required. However, this is means that from an application developer perspective, providing a user experience that simulates statefulness can be difficult - an application that requires authentication via signing needs to remember that the user is signed it as they issue additional requests.

### How can we manage state with HTTP?
HTTP is a stateless protocol, meaning that each request/response pair is a unique entity, and independent of any other request/response pair. However, there are methods that we can use to simulate statefulness in applications using HTTP.

One of the main methods is by tracking a session, using a session identifier/token like a cookie. When a server provides a response to a request, if a cookie does not already exist within the browser, the server will append a session id as part of the request (the session id is saved within the browser), using the `set-cookie` response header. On subsequent request/response cycles, the messages will have a session id appended to it. 

On a client making a request, the server will:
1. Check if the request has the session id
2. Verify the session id is still valid (via business rules to govern session expiry and where to store session related data)
3. Retrieve session-specific resources based on the session id (the session data is stored on the server)
4. Retrieve the application state-specific resources based on the session data, sending it to the client as a response.

Session IDs or cookies are typically relatively short lived - if lost or expired, then the state specific data is lost, and a new cookie or session id must be passed from the server to the client.

Another method that we could use to simulate state is query strings; the query strings provide more specific information as part of a request, and can be used by a server to generate a more specific response, based on the information passed through the query string.

### What is AJAX?
Asynchronous Javascript and XML (AJAX) is a feature that allows browsers to issue requests and process responses without triggering a full page refresh. Without AJAX, every user action could potentially require a full page refresh, which is very expensive, resource-wise. When a user performs an action, an AJAX request is sent to the server, just like a regular request/response cycle. However, AJAX uses callbacks, which is logic that is passed to some function after a certain event has happened - the callback is usually triggered when the response is returned. In this way, the callback function is able to update only part of the page (instead of fully refreshing the page) on receiving the response from the server.

### What is a `GET` request? Describe the process of issuing a `GET` request.
When we type a URL into the address bar of our web browser and press Return, we are issuing a `GET` request - i.e. we want to fetch some resources from the server. As the first step, the browser will make a request to the Domain Name System servers, so that an IP address corresponding to the URL can be found to route the request (i.e. it's a field in the header of the Network/Internet layer PDU).

The `GET` request is actually a request-line - it contains additional information in _request headers_ other than just the destination IP address. This allows the server to interpret what specific information to return, and how it should return this information. Standard request headers include:
- The `method`: the value of this is `GET` in a `GET` request. This tells the server the client wants to retrieve some information. This is required.
- The `path`: this indicates _what specific resource_ the client is after. This is required in a request-line (contrast this with the `path` in a URL, which is optional)
- The `host`: this is equivalent to the `host` in a URL (e.g. `www.google.com`). This is required as of HTTP 1.1.
- The `version`: in a web browser context, this is the version of the HTTP that should be used. This is required as of HTTP 1.0.

The request is then passed down the different layers, within and across different networks via routers and switches, until it is received by the server. The server will then fetch these resources and send them back to the browser. The browser then interprets the data sent from the server and displays a page (making additional `GET` requests as it interprets references to other resources in the initial response). The browser is able to interpret the response (and how it should render the page) according to the response headers.

### What is a `POST` request?
A `POST` request is a type of HTTP request, used when the user wants to add or change values that are stored on the server. It's typically used when query string parameters do not fit the use case (e.g. too much information to be sent through query string parameters, or sensitive information). Data is sent through the HTTP body. An example use case is submitting a form to a server.

### What is a HTTP Header?
HTTP headers are colon separated name-value pairs sent as plain-text with HTTP messages, which provide metadata alongside the message which can aid in the processing of the request.

Some standard __request__ headers include:
- `Host`: This is equivalent to the `host` in a URL (e.g. `www.google.com`)
- `Accept-Language`: This specifies what language the response resources should be in (e.g. `en-US,en;q=0.8`)
- `User-Agent`: This identifies the client (e.g. `Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5)`)
- `Connection`; This specifies what type of connection the client would prefer (e.g. `keep-alive`)

Some standard __response__ headers include:
- `Status`: This indicates the status of the request (e.g. `302 Found`). This is always returned, and required as part of a HTTP response header.
- `Content-Encoding`: This identifies the encoding used on the data returned by the server (e.g. `gzip`)
- `Server`: The name of the server returning the data (e.g. `thin 1.5.0 codename Knife`)
- `Location`: In the case of a status 302, this indicates where the resource has been relocated to, and where the browser should issue another request to (e.g. `https://www.github.com/login`)
- `Content-Type`: This indicates the format of the data returned (e.g. `text/html; charset=UTF-8`)

### HTTP is a text protocol, and has some security issues. How do we mitigate these security issues?
As HTTP is a text protocol, the request is sent as strings. This means that things like the query parameter strings in a URL, or the cookie/session id can easily be read by a hacker, using packet sniffing techniques. This means they are able to read any information sent to the server or client, and simulate application state using the session id, allowing them to pose as a client without having to access a user's username or password.

In order to protect against this, there are number of methods that can be used:

__HTTPS__: This is secure HTTP. We can identify resources accessed via HTTPS in the scheme of the URL (`https`). With HTTPS, every request/response pair is encrypted before it is passed to the Network layer. This means that even if a hacker were able to use a packet sniffing technique, the resulting message would be encrypted and could not be read. Transport Layer Security is the crytographic protocol used for encryption by HTTPS.

__Same Origin Policy__ - Resources that originate from the same origin have unrestricted access to interact with each other. Resources that originate from different origins have more restrictions in respect of their interactions  - linking, redirects, resource embedding (scripts and CSS stylesheets, as an example) and form submissions are common exceptions to the Same Origin Policy. Resources that come from the same origin have the same `scheme`, `host` and `port`. Same Origin Policy is most useful in restricting interactions between resources that have been accessed programmatically (e.g. through an API like `XMLHttpRequest` or `fetch`).

We can get around the Same Origin Policy by using CORS (Cross origin Resource Sharing), which can be implemented by including certain HTTP headers (e.g. the `Access-Control-Allow-Origin` response header) in the request/response messages.

### What are some ways in which HTTP is vulnerable to hackers?
__Session hijacking__ occurs when a hacker is able to use packet sniffing techniques to capture the cookie or session id in a request/response message. With this session id, the hacker is able to send requests to the server with this session id, upon which the server will respond with state-specific data, allowing hackers to access a user's specific state of application without access to their username or password.

This can be combatted by resetting sessions, particularly on sensitive user interactions. When a user authenticates by logging in, a successful login should render older session ids invalid, and create a new session id. Examples of this are e-Commerce sites, which usually require the user to re-login when attempting to pay with a credit card.

Applications can also set expiry times on session ids - this limits the time that a hacker could have access to state-specific application data, reducing the potential harm to the user.

We could also limit the potential for session hijacking by using HTTPS in the request/response cycle, thus encrypting any session ids attached to messages sent between client and server.

__Cross Site Scripting (XSS)__ is another method that HTTP could be vulnerable to hackers. XSS occurs when some element of the application allows hackers to directly inject JavaScript into a site and cause the server to run that JavaScript when returning the response. A common vector for this are forms, which allow users to input text. If the server does not __sanitise__ the input text, this could cause the server to return the response with the JavaScript code injected into the relevant resources.

One way of limiting the potential of XSS is to _sanitise_ user input. This could be by only limiting the input text of users to Markdown format, which prevents code from being executed, or removing certain strings such as `<script>` which enable JavaScript code to run.

Another way to limit XSS is to _escape user input_. With this method, characters that could be interpreted as HTML or JavaScript code are replaced with a combination of ASCII characters, which indicate to the client to simply display the character as is and not process it like code.

### What is Transport Layer Security? What does it do?
Transport Layer Security (TLS) is a security protocol that can be used to encrypt HTTP messages as part of HTTPS (Secure HTTP). It is highly recommended to use TLS, since basic HTTP request/response messages are sent as plain text - TLS can potentially prevent packet sniffing techniques and hackers from session hijacking. It can be thought to exist between the Application and Network layers in the Internet Protocol Suite model.

TLS is established after a TCP connection has been established after the TCP handshake (it is a protocol reliant on using TCP at the Transport layer). The TLS handshake then occurs, to create a _secure_ connection. No application data is sent until this TLS handshake has been completed.

TLS can provide three types of security measures (though not all might be appropriate, depending on the application use case).
- Encryption: Encoding a message so that only the intended recipient is able to decode the message.
- Authentication: Verifying the identity of a particular party in the message exchange process.
- Integrity: Checking whether a message has been altered or faked.

### What is the TLS Handshake?
The TLS Handshake is a process used to establish a secure connection, once a TCP connection has been established, and part of the _encryption_ capabilities of TLS. It relies on both an asymmetric and symmetric key encryption.

1. The client will send a `ClientHello` message to the server, indicating a desire to set up a TLS connection. Part of this `ClientHello` message will include the highest version of the TLS protocol that the client can support, as well as a list of Cipher Suites that the client can use to encrypt keys.
2. Upon receiving the `ClientHello`, the server will return a `ServerHello` message, which sets the TLS protocol version, as well as the Cipher Suite to be used for key encryption. The `ServerHello` message also includes a _certificate_, which includes the server's public key, and a `ServerHelloDone` marker to indicate the server regards this part of the handshake as done.
3. Once the client has received the `ServerHello` message, the key exchange process beings. The actual process depends on the algorithm used (decided from the Cipher Suite). 

In the case of RSA:
1. The client will send a `ClientKeyExchange` message, which includes a 'pre-master secret', which is some data that's been encrypted with the server's public key as provided through the certificate in the `ServerHello` message. This message includes the `ChangeCipherSpec` flag, which indicates to the server that the client is ready to start using encrypted communications using the symmetric key. The message also includes a `Finished` flag, which indicates the client is done with this part of the handshake process.
2. The server receives the `ClientKeyExchange` message and decrypts it using it's private key. 
3. The client and server then each generate a symmetric key based on the pre-master secret with some pre-agreed parameters. 
4. The server will then send a `ChangeCipherSpec` message to the client with a `Finished` flag. This indicates that the server is ready to start using a symmetric key to start communications, and secure communications can begin.

One downside of the TLS Handshake is the latency it adds to the overall connection process - there are potentially two additional round trips worth of latency before any application data is even sent (on top of the latency introduced by the TCP handshake process).

### What is a Cipher Suite?
A cipher suite is a set of cryptographic algorithms used in encryption/decryption and other related tasks. TLS uses the cipher suite to determine which algorithm should be used to generate the symmetric key, based on the cipher suites a client supports.

### What is encryption in the context of TLS?
Generally, encryption is the process of obscuring the contents of a message so that only an authorised party is able to decrypt that message and see it's contents. In the TLS context, encryption refers to both the client and server encrypting and decrypting their messages with a symmetric key generated through the TLS handshake process, so that no other parties are able to see what the contents of the messages being exchanged are.

### What is authentication in the context of TLS?
Authentication more generally is the process of verifying the parties involved in the message exchange are who they say they are. In the TLS context, this is achieved through certificates (via asymmetric key encryption) and the chain of trust.

During the TLS handshake process, the server will send a certificate as part of it's `ServerHello` message back to the client. This certificate (which includes the server's public key) is sent along with a __signature__, which is some data encrypted with the server's private key, as well as the unencrypted version of this same data used to generate the signature. 

On receiving the `ServerHello` message, the client will then decrypt the signature using the public key contained with the certificate and compare the results to the unencrypted original data. If the two match, then this serves as proof that the server is who they say they are (as no other party should have access to the server's private key and be able to encrypt a message with it).

This asymmetric key encryption is almost the opposite of what happens during _encryption_ in the TLS protocol; for encryption, the client encrypts data using the public key, and the server decrypts the message using the private key. This is because the priority here is to safeguard the message contents. For _authentication_ purposes, the contents of the message aren't so important as _who_ is sending it, and so using the public key (which is available to anyone) to decrypt the message shouldn't cause message contents to leak unnecessarily.

### What is symmetric key encryption? What is asymmetric key encryption? What's the difference?
Symmetric key encryption is the process of parties involved in a message exchange encrypting their messages by using the same key. This symmetric key is kept secret between the two parties. This ensures that parties who aren't intended to be involved in the message exchange are not able to read the data being exchanged.

However, when transferring data using digital infrastructure, the initial transfer of the symmetric key to both parties can be tricky - the message could be intercepted by a third party, giving them access to the symmetric key and thus access to the data being transferred. As such, asymmetric key encryption can be used to mitigate this risk. 

With asymmetric key encryption, there are two different keys used for encryption (a _public_ key) and decryption of data (a _private_ key). In the context of a client and server, the public key is usually freely available to any client that wants to send messages to the server. However, the private key is only available to the server, meaning that only the server is able to decrypt messages encrypted using the public key. 

It should be noted that asymmetric key encryption is _unidirectional_; in our example above, only data sent from the client to the server is encrypted; if the server itself did not employ some asymmetric key encryption technique, these responses could be visible to third parties. The client would also need to share a public key with the server, so that it could encrypt the messages in a way that only the client could decrypt. Otherwise, algorithms such as RSA allow both parties to agree  upon certain parameters to individually generate a common symmetric key after asymmetric key encryption occurs, without having to explicitly transmit this symmetric key over a message.

### What is a certificate?
A certificate is a means of identifying the party who possesses it. In the context of the TLS protocol, it is involved during the TLS handshake; sent to the client along with a public key by the server as part of the `ServerHello` message. The certificate also contains the public key that the client can use for encrypting messages to be sent to the server as part of the initial TLS handshake.

From an authentication perspective, the certificate provides assurance that they party is who they say they are. However, certificates could be faked - this is where Certificate Authorities (CA) come in. When a certificate is issued to a party via a CA, that CA is:
1. Verifying the party is who they say they are (how this is actually done depends on the CA; it could be checking that the party legally owns the domain, etc.)
2. Digitally signing the certificate being issued - when a certificate is issued, the CA usually encrypts some data in the form of a signature, and adds this along with an unencrypted version of the same data to verify that the certificate was issued by the CA, all within the certificate itself.

A certificate will generally be signed by one CA. A CA will sign the end-user's certificate, while a Root CA will sign the intermediate CA's certificate. This creates a 'chain of trust', whereby a Root CA is the end-point in the chain of trust, and assumed to be a trustworthy party. 

The 'chain' structure also provides a layer of security for the Certificate Authorities; Root CA private keys are typically kept behind many layers of security to prevent it from being exposed. Root CAs are also able to invalidate certificates issued by an intermediate CA in the event that the intermediate CA's private key is exposed (effectively invalidating all the certificates down the chain).

### What is integrity in the context of TLS?
Integrity is the process of ensuring that a message has not been tampered with or faked as it is transmitted to another party. In the context of the TLS protocol, the TLS record (the name for the data payload) will include a MAC (Message Authentication Code) header. This works like the `checksum` header values in the PDU of other lower layers.

The sender generates a _digest_ of the payload, which is a small sample of the actual message being sent. The digest is generated using a hashing algorithm and pre-agreed hash value that was negotiated as part of the Cipher Suite in the initial TLS handshake process. This is the value in the `MAC` header.

When the recipient receives the message from the sender, it will decrypt the payload using the symmetric key, and also use the same hashing algorithm and pre-agreed hash value to generate a digest from the data. If the two encrypted digests match, then this indicates the message has not been altered during transmission.
