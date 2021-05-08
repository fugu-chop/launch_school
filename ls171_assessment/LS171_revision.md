### What is the internet?
The internet is a network of networks which permit the transfer of information across different networks and devices. The World Wide Web is a service that can be accessed via the internet.

### What is a network?
A network, at it's simplest implementation, is two or more devices connected to each other so that they are able to exchange information. In a home office context, these end-user devices would likely be connected to a switch. In this way, all devices connected to the switch are able to exchange data with other devices on the same network (i.e. the Local Access Network, or LAN). Without a router however, these devices will __not__ be able to communicate with devices on a _different_ network.

### What is a protocol?
In the context of computer networks, a protocol can be defined as a system of rules that govern how data is exchanged or transmitted. For network communication purposes, we can think of protocols defining a system of rules for:
1. _Different_ aspects of exchanging data (e.g. how messages should be transmitted __within__ a network, versus __between__ networks).
2. The _same_ aspect of exchanging data, but with different functionalities (e.g. the choice of UDP or TCP at the Transport layer).

### Explain the 'layered system'
'Layered systems' are models intended to group different aspects or processes within the network communication process, such that each 'layer' should be distinct from other layers, with it's own protocol. There are two dominant 'layered' system models:
1. OSI (Open Systems Interconnection)
2. Internet Protocol Suite (also known as the TCP/IP model)

They are roughly equivalent (though some overlap does occur) in respect of the 'layers' that they describe. They differ in respect of how the layers are divided:
- The TCP/IP model divides the layers in terms of the __scope__ of communications (e.g. within a local network, between networks, etc). 
- The OSI model divides the layers in terms of the __functions__ that each layer provides (physical addressing, logical addressing and routing, encryption, compression, etc).

### What is encapsulation in the context of the layered system?
In the context of the layered system, encapsulation is the process of combining the data payload of a given layer, combining it with a number of headers (metadata related to the data payload as defined by the protocol) to create a _Protocol Data Unit_, and pass it to another, lower layer (such as the OSI or TCP/IP model) to handle the next aspect of network communication. Protocol data units at different layers have different names.

Encapsulation is useful in network communications because it abstracts away the protocol specific implementations at other 'layers' within an OSI or TCP/IP model - each layer is responsible for one aspect of communication (depending on the network model) and separated from other layers.

### Describe the physical layer.
The physical layer in the OSI network model denotes the physical transmission of data in the form of bits, converted to a signal, which could be electrical (via copper wire), light-based (optic fiber cable) or wave based (radio transmissions). The 'protocol' used at this layer are really the laws of nature, which define natural limits how how fast and far different forms of signal transmission can occur.

The OSI model defines a Physical layer as the bottommost layer of its model (Layer 1). The Internet Protocol Suite doesn't really concern itself directly with physical interfaces, though it does include some physical functions in the Link layer.

### Describe the characteristics of the physical layer.
The physical layer has some characteristics that impact how quickly data can be transferred.

_Bandwidth_ is the amount of data that can be transmitted over a set period of time (e.g. a second). We can think of this as the number of lanes on a road - the more lands, the more traffic the road can handle in a given time period.

_Latency_, which is the delay between the time from which the data is transmitted to the time it is received. There are a number of different factors that contribute to overall latency:
- Propagation delay: This is the time it takes for data to leave one point and reach other as defined by the laws of nature. Continuing our road analogy, this is the speed limit of the road.
- Transmission delay: This is the time it takes to push data onto a link, as data travels from network device to network device. This is the equivalent of having to turn at an intersection.
- Processing delay: This is the time it takes for a network device to process the data it's been passed. This is equivalent to setting up a checkpoint before the intersection in our road analogy.
- Queuing delay: If more data is sent to the network device than it can process at a given time, that data is sent to a buffer. This is the time the data spends in the buffer, not being processed. In our analogy, this is equivalent to traffic jams leading up to the checkpoint.

### What is the Round Trip Time (RTT)?
Round Trip Time is the time taken between a message being sent by a host and the the acknowledgment being received.

### What is the Link/Data Link Layer? What protocols does it use?
The Link/Data Link layer is responsible for the transmission of data between devices _within_ a network. Within the OSI model, the Data Link layer is Layer 2 and comes in between the Physical layer (1) and the Network layer (3). Within the Internet Protocol Suite, the Link layer is layer 1, since this model doesn't define a specific layer for the physical network. Within both of these models, the Link/Data-Link layer works as an _interface between the workings of the physical network and the more logical layers above_.

The most prevalent protocol at the Link/Data Link layer is the Ethernet protocol, which provides for standards of physical infrastructure (e.g. how a CAT6 Ethernet cable should be constructed), as well as how data should be transmitted within a local network.

### What functionality does the Ethernet Protocol provide?
In respect of transmitting data across different devices on a local network, the two key roles the Ethernet protocol provides are:
1. Framing
2. Addressing

__Framing__ is structuring the data at the Link/Data Link layer so that it can be passed to the physical layer for transmission to another device. Framing occurs by adding headers to the data payload (i.e. the protocol data unit passed down from the Internet/Network layer), where the Ethernet protocol specifies what order and size these headers should be. When these headers are added, the protocol data unit is now known as a _frame_. 

This structure ensures that other network devices using the Ethernet protocol are able to correctly 'reconstruct' the signal received from the physical layer as a frame, ready for decapsulation by other layers higher in the network model.

__Addressing__ refers to the requirement for Ethernet frames to be sent to the next intended network device. The Ethernet protocol mainly does this through MAC addresses (Media Access Control), which are physical 'burned-in' addresses that each network device will have. These MAC addresses (both source and destination) are contained in the header of the Ethernet frame. 

The Ethernet protocol (from a data transfer perspective) is 'node to node', meaning that the source and destination MAC addresses will change as the data is passed from one device to the next on a local network. A network device will be responsible for decapsulating the frame to determine the destination IP address (i.e. the ultimate destination of the data). 

The Address Resolution Protocol (ARP) is then used to determine the MAC address of the next hop (ARP queries the next endpoint by IP address, and that query returns the MAC for that endpoint). The network device then re-encapsulates this packet as a frame, to be passed to the next device.

### What is the Internet/Network Layer? What protocols does it use?
The Internet/Network layer is responsible for the transmission of information between hosts across different networks. In the OSI model, the Network layer is layer 3 (between the Data Link and Transport layers). In the Internet Protocol Suite, the Internet layer is layer 2 (between the Link layer and the Transport layer). The most frequently used protocol at this layer is the Internet Protocol. 

Like other layers, the Internet Protocol has two specific functions:
1. Structuring data into an internet packet, so that it can be encapuslated and passed down to the Link/Data-Link layer.
2. Addressing, or sending information to the correct location through use of IP addresses.

In terms of the data structure, the data payload at the Internet/Network layer is combined with a number of headers; some of the more important fields are:
- Source and Destination IP addresses, which direct the information across different networks to the correct device (and is how the Internet/Network layers achieve addressing)
- Version, which specifies the version of the Internet Protocol to be used (which will affect the headers) - e.g. IPv4 or IPv6
- Time to Live, which specifies how many 'hops' a packet travel before being discarded (this stops lost packets from endlessly circulating networks)

__Addressing__ capabilities are handled by IP addresses. IPv4 addresses are 32 bits in length, split into 4 bits of eight. Unlike MAC addresses found on the Link/Data-Link layer, IP addresses are _logical_; they can be split into hierarchies, such that particular _ranges_ of IP addresses will consistently cover different parts of a network (a _segment_, usually denoted by the _network_ address), unlike MAC addresses, which provide no logical structure to which MAC addresses might be within a network. The splitting of IP addresses into logical, hierarchical ranges is known as _subnetting_. IP addresses can be re-assigned as necessary (each device on a network will have an IP address as well as a MAC address).

### What is DNS? What is it's function?
The Domain Name System (DNS) can be thought of as a 'translation' service for URL domains. After a user types a URL into their web browser, the browser will make a call to a DNS server to try find the corresponding IP address for the URL domain provided by a user (since IP addresses are how network traffic is sent across different networks). 

DNS servers are distributed hierarchically, such that if a DNS server does not have the IP address for a domain, the DNS server will forward the request up the hierarchy until one of the DNS servers is able to return an IP address (or returns an error if that domain does not have an associated IP address). Once the web browser has the appropriate destination IP address, it is able to structure the request as an HTTP request and pass it to lower levels for encapsulation and transmission.

### How are IP addresses used to transmit data? *
The Internet Protocol is an 'end-to-end' protocol - it is concerned with the ultimate start and destination for the transmission; the routing of device to device is a separate concern abstracted away to a lower level. When a frame is being sent to another network, it must be decapsulated by routers that direct traffic across and between networks to reveal the packet (the protocol data unit of the Network/Internet layer). The packet has the destination IP address in it's headers.

The router then looks up it's _local routing table_, which contains a list of network addresses. These network addresses cover a _range of IP addresses in a subnet_. Based on which devices cover which IP ranges, the router will decide the next best device to route the packet to. The router will re-encapsulate the packet into a frame with the new destination and source MAC addresses, and the process repeats until the data reaches the destination IP address.

### What is the transport layer?
The Transport layer is responsible for multiplexing numerous sources of application layer messages over a single communication channel with another party. Put simply, it allows different applications to share a single connection to a server, but still allow the server to correctly interpret requests (depending on the ports selected), and send the responses back to the correct applications on the same machine.

In the OSI model, the Transport layer is a layer between the Presentation and Network layers. In the Internet Protocol Suite, the Transport layer is layer 3 (between the Application and Internet layer), which combines parts of the Session and Transport layer in the OSI model. The two most popular protocols at the Transport layer are Transmission Control Protocol (TCP) and User Datagram Protocol (UDP). Which one is used will depend on the use-cases of the underlying application.

### What is multiplexing? Why is it necessary?
Multiplexing is a capability observed across various layers within the OSI or TCP/IP network models. It refers to the ability to send multiple streams of data across a single communication channel. In the case of the physical layer in the OSI model, multiplexing is achieved via sending light signals refracted at different angles in an fiber optic cable, or radio waves transmitted over the air on different frequencies.

In the context of the Transport layer, multiplexing is the capability of the Transport layer protocol to carry messages from different applications over a single communication channel with the server, and still have the server be able to interpret the different requests and serve responses back to the correct applications. 

Multiplexing on the Transport layer relies on the use of _sockets_, or the combination of an IP address and a _port_ (an identifier for a specific application process) - a TCP segment/UDP datagram header will include both the source and destination sockets (known as a _four-tuple_), allowing the different application messages to be sent to the correct 'locations' on the server to have an appropriate response returned to the correct applications on the client machine. As part of this, the server needs to be able to _demultiplex_ messages being sent over this single communication channel to correctly interpret them.

### What is a port? What is it used for?
A port is an identifier for a specific application process. At the transport layer, ports enable multiplexing, which can be achieved when the port is combined with an IP address to create a _socket_ as the protocol data unit is passed down to the Internet/Network layer. Servers generally have a default port to respond to specific application requests - e.g. HTTP requests are usually sent to port 80 on the server machine, while HTTPS is sent to port 443. The client's ports are usually randomly chosen from a range that are designated as 'ephemeral ports' (i.e. used specifically for multiplexing/demultiplexing application data), which will depend on the operating system in use by the client.

### What is a socket? What is it used for?
A socket is a combination of an IP address and a port number. Sockets enable multiplexing to occur - the transfer of multiple streams of application data over a single communication channel between server and client. It is the socket that allows the client and server to distinguish the different types of application data being transmitted, and route them to the correct 'location' on the host machine to be processed. It can be regarded as a communication endpoint.

### What is a connection-oriented network system? What is an example of this?
A connection-oriented network system operates on the basis that each individual application on the client machine that is sending data to a server should have a dedicated virtual connection through instantiating multiple socket objects on the server for each application, where each connection listens specifically for a particular socket (IP Address and port combination). Through a connection-oriented network system, reliability can be introduced into the transport layer, something which lower layers do not handle. TCP is an example of a connection-oriented protocol.

### What is a connectionless network system? What is an example of this?
A connectionless network system opereeates on the basis that the server machine does not need to instantiate multiple socket objects to listen for different streams of application data - messages are simply responded to in the order that they come. This means that a lot of reliability-related functionality is not inherently present in a connectionless system since dedicated virtual connections between the client and server for specific applications do not exist. The advantage of connectionless network systems is that there is generally less latency in message transfer, since there is less overhead that needs to occur before message can be transferred.

### What is network reliability? How do we achieve network reliability?
Network reliability typically has four key attributes:
1. In-order delivery; messages are received and processed in the order they are sent.
2. Error detection; the transport layer PDU generally has a checksum header (though this can be redundant, depending on the protocols used at lower layers)
3. Re-transmission of lost/corrupted messages through acknowledgment messages, timeout periods and 
4. Duplication handling through sequence numbers in PDU headers.

It is incumbent on the Transport Layer to implement these reliability functions; while lower levels can provide for some degree of error detection (e.g. the IPv4 protocol on the Network/Internet layer has a checksum header value), if the message is corrupted, the message is simply dropped; there is no allowance for message retransmission at these levels. These reliability functionalities are most typically found in connection-oriented protocols such as TCP, though they can be built on top of connectionless protocols like UDP (though connectionless protocols do not have network reliability functionality by default - it is up to the application developer to build these).

### What is TCP? What are it's downsides/upsides? *
Transmission Control Protocol (TCP) is a connection-oriented protocol used at the Transport Layer. It is a protocol that enables reliability functionality not available at lower levels of either the OSI or TCP/IP network system models. Like with UDP, TCP makes use of multiplexing to enable multiple streams of application data to be sent over a single communication. However with TCP, as it is connection oriented, individual socket objects are instantiated on the server side, so that dedicated virtual connections between client and server are established for each application data stream

TCP provides reliability by first establishing a TCP connection on each request (in theory) via the TCP handshake - in this way, a connection can be verified before any application data is sent. TCP also provides acknowledgments for each message sent; messages where an acknowledgment is not received from the server (either because an acknowledgment was never sent, lost, timed-out or the original data was never received by the server) can be retransmitted. 

The `sequence` and `acknowledgment` number fields in a TCP header also allow in-order delivery and handle duplication. TCP segments are intended to be processed in the order they were sent - if a particular message is missing, the `sequence` number fields in the messages received by the server will not be sequential, and missed packets will be retransmitted. 

While not specific to TCP, the fact that in-order delivery is part of TCP's reliability features also means that _Head-of-Line blocking becomes an issue_. Because TCP segments are intended to be processed in the order they were sent, if a particular message goes missing and needs to be retransmitted, this will stop other subsequent messages from being processed, even though the server may have received them - they are put in the server's buffer, and this contributes to queuing delay, a contributor to latency.

While TCP adds reliability to the connection and message transmission process, it adds latency through the TCP handshake required before each request (in practice `keepalive` connections and pipelining enable a particular connection to be reused for multiple requests). Also, having to send an acknowledgment after each message sent slows the overall data transfer process down. TCP also provides for latency related optimisations such as flow control and congestion avoidance.

### What is UDP? What are it's downsides/upsides?
The User Datagram Protocol (UDP) is a connectionless protocol used at the Transport layer. Like TCP, it provides for multiplexing capabilities, meaning that multiple different streams of application data can be transmitted over a single connection between two hosts. 

Unlike TCP, as UDP is a connectionless protocol, only a single socket object is instantiated on the server machine per client; there is __no__ dedicated virtual connection for each application sending messages to the server. Instead, messages are processed as and when they are received by the server, in whatever order the server receives them. UDP does not require the client to wait for a connection to be established like the TCP handshake - the client can immediately start sending data.

UDP does not provide for reliability functionality by default; we can see in the UDP datagram header that there many fewer headers, which indicate that UDP does nothing for in-order delivery, retransmission or duplication handling (only a `checksum` field exists for integrity checking), nor does it handle performance optimisations like flow control or network congestion. Part of UDP's appeal is it's flexibility - application developers may choose to implement some elements of reliability on top of UDP if desired (and may choose to implement some form of congestion avoidance as a matter of good practice).

The main focus is simplicity and speed of data transfer, which may be desirable over TCP depending on the application use-case (e.g. particularly when minimised latency is the focus, and not data integrity, such as video calls). 

### What is the TCP handshake?
The TCP handshake is a three stage process through which a TCP connection is established, before each request is sent by the client (i.e. before any application data can be sent). It works as following:
1. The client sends an empty (i.e. no data payload) TCP segment with the `SYN` flag set to `1` to the server, indicating the client wishes to establish a TCP connection.
2. The server receives the `SYN` message, and returns an empty TCP segment, this time with the `SYN` and `ACK` flags set to `1`, indicating receipt of the `SYN` message.
3. The client receives the `SYN ACK` message, and sends an empty TCP segment with the `ACK` flag set to `1`. This is the acknowledgment message, and at this point, the client is able to start sending application data to the server. After the server receives the `ACK` message, the server can return responses to the client.

In reality, the TCP handshake doesn't occur before each request, connection types like `keepalives` and pipelining allow for multiple requests to be sent over a single connection. Nonetheless, while the TCP handshake is an important part of enabling TCP's reliability functionality, it does this at the cost of latency, since a handshake process has to be conducted fairly frequently (if not on every request).

### What is pipelining?
Pipelining is the process of sending multiple messages over a single connection between hosts, without waiting for an acknowledgment message for each individual message before the next is sent. It is a way to better utilise the available bandwidth of a connection, rather than waiting for a round trip of latency for each message sent when in-order delivery is important. _There is no impact on reliability_ (where applicable), since acknowledgment messages are still sent for each request that's 'bundled' within a window.

In a TCP segment, pipelining is controlled through the `window size` header field, which is also used for flow control and congestion avoidance purposes.

### What is flow control?
Flow control _is a mechanism to avoid overwhelming the receiver with too much data_. When data is sent to the __receiver__, the receiver can only process so much data at any one given time. Excess data is stored within a a buffer, and needs to be 'queued' for processing (which contributes to queuing delay, a contributor to overall latency). If the receiver's buffer is starting to get full, it can indicate this as part of an acknowledgment message by reducing the value in the `window size` header field, which reduces the number of 'requests' sent in a given connection to it. This allows the receiver to 'catch-up' processing the data in it's buffer. This `window size` header value is _dynamic, and can be adjusted throughout the course of a connection_.

### What is congestion avoidance?
Congestion avoidance is a mechanism to avoid any data transfer between two hosts from overwhelming the underlying network. Network devices on a network only have a fixed capacity to process data - when this capacity is exceeded, the excess data is put into a buffer. However if the buffer becomes full, the excess data is simply dropped. 

As this data would never receive a response (since the receiver never gets it), TCP would handle data retransmission. Retransmission is inefficient and should be minimised where possible, as it adds to overall latency. TCP can detect if there is an excessive level of retransmission occuring, which would indicate that the network has too much data being sent across it, and reduce the size of the transmission window. 

### What is the application layer? *
The application layer is the top layer in both the OSI and Internet Protocol Suite network models. At it's core, the application layer is responsible for providing communication services to the application with the other layers, as well as structuring the message in such a way that is conducive for encapsulation and transmission, as well as allowing application services on other hosts to interpret it. The application layer has many different protocols, depending on the use case.

### What is HTTP? *
HyperText Transfer Protocol (HTTP) is a text-based protocol used at the application layer, and provides uniformity to the way resources are requested and delivered over the web. It follows a _request/response_ cycle - a client web browser will issue a request to a server, and wait for the server to provide a response. 

### What is a URL? How is it different from a URI? *
Per RFC3986, a URI (Uniform Resource Identifier) is a series of characters that identifies an abstract or physical resource. A URL (Uniform Resource Locator) is a subset of a URI - in addition to identifying an abstract or physical resource, it also describes the primary access mechanism of that resource (i.e. the network location).

### What are the components of a URL? *
A URL (Uniform Resource Locator) can have 5 components to it:
- _Scheme_: This identifies __how__ to access the resource by referencing the protocol. It preceeds the `://` characters in a URL.
- _Host_: This identifies the domain of the URL, which corresponds to an IP address which can be found by making a call to a DNS server (i.e. __where__ to find the resource)
- _Port_: This is the identifier for a specific application process on the server. Even if not excluded included within a URL, it is a required component (if not explicitly stated, it's usually a default port depending on the application, such as port 80 for HTTP requests).
- _Path_: This identifies where on the server the specific resource can be found, and is optional
- _Query Strings_: This is an optional name-value pairs that can be used to convey specific information to a server as part of an HTTP `GET` request. A URL with the `?` character followed by `name=value` pairs, separated by the `&` character has query string parameters.

### What is a query string parameter? Why would we use it/not use it?
A query string parameter is an optional component of a URL. We would use it as part of an HTTP `GET` request when we want to convey some further information to the server. They can be identified as following a `?` symbol, as `name=value` pairs, separated by the `&` symbol. While they add the ability to convey further information to a server, they have some limitations:
- As HTTP is a text based protocol, a URL can be plainly seen as part of a request. This makes query string parameters unsafe to convey sensitive information, such as usernames and passwords.
- Query String Parameters have a maximum length, meaning there is a limit to the information that can be passed strictly through the URL.
- Reserved or unsafe characters - URLs only support the standard 128 ASCII characters. This means if we want to convey text information that contains certain characters such as `&` or spaces, we must encode them. 

In the first two use cases, it's probably better to send an HTTP `POST` request instead of a `GET` request. 

### What is URL encoding and why would we use it?
URLs only support the standard 128 ASCII characters. Certain characters that don't exist in this 128 character set, or are reserved or unsafe (i.e. serve a specific function in the URL or could be interpreted as either text information or serving a purpose in the interpretation of a URL), must be encoded before they can be used as part of an HTTP request. We do this by adding a `&` symbol followed by two _hexadecimal digits_ that corresponds to an ASCII character.

### What is a server? What are the infrastructure components of a server?
A server is a device that is designed to process incoming requests and return some information. Servers typically include three core types of infrastructure (the actual hardware configuration may differ):
- A web server: This is designed to return static assets, such as text, images or videos, where no additional business logic or processing of those assets is required.
- Application server: This a component that applies business or application logic to provide a response to a request. This is where application code that's deployed to a server would live.
- Data Store: This is where data can be retrieved, created or updated and persisted on the server (an example might be some sort of _relational database_).

### What are resources? *
A 'resource' is a generic term for anything that can be interacted with on the Internet with a URL. These could be static assets like pictures, videos or audio files, but also applications. 

### What is statelessness? Why is it an issue with HTTP?
HTTP is a stateless protocol. This means that request/response pairs are independent and have no context of the information contained by other request/response pairs. This creates challenges in application development where certain data should be served to a user based on previous interactions (i.e. need state). We can simulate state using HTTP using mechanisms like session ids.

### How can we manage state with HTTP?
We can simulate statefulness with HTTP by using session ids (e.g. cookies). When a client makes an HTTP request to a server, the server can:
1. Check whether that request has a session id attached to it
2. If present, validate whether that session id is still valid
3. Pull resources that correpond to that session id in order to recreate a certain experience for the user
4. Recreate an application state based on that session id and return this to the client as a response.

If the client request does not have a session id, the server can attach a session id as part of the response, which will be used for future requests by that client.

### What is a `GET` request? Describe the process of issuing a `GET` request. *
A `GET` request is a type of HTTP request used to retrieve resources from a server. This is text based, and has some requirements in respect of the structure of the `GET` request (known as the request-line):
- The _method_ - this is the type of HTTP request, or `GET` in this example
- The _host_ - this is the domain name of the server, which the browser will use as part of a request to a DNS server in order to find the IP address (required as of HTTP 1.1)
- The _path_ - this indicates __where__ the resource is located on the server.
- The _version_ - this is which version of HTTP should be used for the request (necesssary as of HTTP 1.0)

If the returned resource contains references to other references, the web browser will make _separate requests for each resource reference_.

### What is a `POST` request?
A `POST` request is a type of HTTP request, usually for triggering some action on the server, such as updating information. It's used when query string parameters might not be appropriate within a `GET` request due to HTTP being a text-based protocol - e.g. if we want to pass sensitive information like usernames or passwords, or there is too much information to be passed through the URL as a query parameter.

### What is a HTTP Header?
An HTTP header contains metadata alongside the request or response being issued that assist in the browser or server interpreting how to process resources.

Some frequently used __request__ headers include:
- `Host`: This is equivalent to the `host` in a URL (e.g. `www.google.com`). This is required as part of the request-line.
- `Accept-Language`: This specifies what language the response resources should be in (e.g. `en-US,en;q=0.8`)
- `User-Agent`: This identifies the client (e.g. `Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5)`)
- `Connection`; This specifies what type of connection the client would prefer (e.g. `keep-alive`)

Some frequently used __response__ headers include:
- `Status`: This indicates the status of the request (e.g. `302 Found`). This is always returned, and required as part of a HTTP response header.
- `Content-Encoding`: This identifies the encoding used on the data returned by the server (e.g. `gzip`)
- `Server`: The name of the server returning the data (e.g. `thin 1.5.0 codename Knife`)
- `Location`: In the case of a status 302, this indicates where the resource has been relocated to, and where the browser should issue another request to (e.g. `https://www.github.com/login`)
- `Content-Type`: This indicates the format of the data returned (e.g. `text/html; charset=UTF-8`)

### HTTP is a text protocol, and has some security issues. How do we mitigate these security issues? *
As HTTP is text based, any third party could use packet sniffing techniques to intercept and read the requests. This is problematic if we are sending sensitive information such as passwords or bank details, or even if a particular session id is contained within a request or response - the hacker could easily send a fake request with the session id, and the application would recreate the application state based on that session id, without requiring any authentication details.

One of the ways to mitigate this risk is to use __HTTPS__ (Secure HTTP). With https, before a request or response is passed to the Transport layer, it is encrypted using some algorithm. This means that even if a hacker were able to intercept a message, they would not be able to read it. An example of this is Transport Layer Security (TLS), which is a protocol used to encrypt HTTP requests.

Another way to mitigate risks is to use a __Same Origin Policy__. This means that resources that share an origin (i.e. have the same scheme, host and port) can freely interact with each other; however, if resources do not share an origin, their interaction is more limited. There are quite a few exceptions to the Same Origin Policy - it is most useful at restricting interactions between resources that are being accessed programmatically (e.g. through an API like `XMLHttpRequest` or `fetch`).

### What are some ways in which HTTP is vulnerable to hackers?
As HTTP is text based, it can be vulnerable to a few hacking techniques.

_Session Hijacking_ occurs when a hacker is able to obtain a session id through packet sniffing on unencrypted HTTP requests or responses. With this session id, the hacker is able to create a 'fake' request with that session id, and the server will return a stateful response, which could be as dangerous as accessing a logged in state for a user's banking application, all without needing that user's authentication credentials. This risk can be mitigated by:
- Encrypting requests or responses using HTTP so that the session id cannot be easily read
- Setting expiry times for sessions, so that even if a hacker is able to obtain a session id, that session id is only valid for a certain amount of time, limiting the potential damage that can be done
- Requiring authentication and new session ids to be created on sensitive actions - when a user is about to perform some sensitive action such as paying for a product on an e-commerce website, the application can force users to login again, rendering any old session ids invalid. This reduces the risk of an intercepted session id from being used to recreate a particular application state.

_Cross Site Scripting (XSS)_ occurs when a user injects some code into an HTML document as part of a request (such as a form submission). When the server receives that request, it may execute that code as part of the response, which may lead to undesirable outcomes. The Single Origin Policy would not help with guarding against this as the code is executing from the same origin. A way to mitigate this is to sanitise the user input; certain strings that could be used to execute scripts (such as `<script>` for JavaScript) could be deleted before that form is submitted, preventing that code from being executed. Another way to minimise the risk of XSS is to not allow submission of HTML format resources, instead preferring a format like Markdown, which prevents code from being executed. Another option is to escape all input from the user, such that it is interpreted as plaintext rather than a script or HTML file that can be executed or displayed.

### What is Transport Layer Security? What does it do? *
TLS (Transport Layer Security) is a protocol that operates between the Application and Transport layers that encrypts messages sent between client and host in a HTTP request/response cycle. This is necessary for creating a secure transfer of messages as HTTP is a purely text-based protocol, meaning a third party could otherwise intercept a message and read it's contents. TLS uses a TLS handshake process to establish a secure connection after a TCP handshake has been completed. 

TLS provides three key functionalities in respect of security:
1. Encryption: Encoding a message so that only authorised parties are able to decrypt the message and read the contents
2. Authentication: Verifying that a party in a message exchange is in fact who they say they are.
3. Integrity: Checking that a message has not been faked or altered during the message exchange process.

An equivalent protocol exists for UDP - Datagram Transport Layer Security (DTLS).

### What is the TLS Handshake? *
A TLS handshake is the process that occurs after a TCP connection has been established to allow for client and host to encrypt and decrypt messages. The overview of the process is:
1. The client will send a `ClientHello` message to the server, communicating the highest version of TLS and list of Cipher Suites it can support.
2. The server, receiving the `ClientHello` message, will send a `ServerHello` message, which sets the TLS version and confirms the Cipher Suite to be used. It also sends this with a certificate (which contains the public key used for asymmetric key encryption), and a `ServerHelloDone` marker, indicating the server is finished with this step of the TLS Handshake. 
3. At this point, the key exchange process is ready to begin; the actual process will depend on the Cipher Suite selected. 

In the case of RSA:
1. The client then sends a `ClientKeyExchange` message, with a 'pre-master secret' encrypted using the public key contained in the certificate. It also contains a `ChangeCipherSpec` marker, indicating it is ready to start communications using a symmetric key.
2. The server decrypts the message using it's private key.
3. The server and client then both generate a symmetric key using the pre-master secret and pre-agreed parameters using the Cipher Suite.
4. The server then responds with a `ChangeCipherSpec` message with a `Finished` marker, which signals that the servers is ready for encrypted message transfer, and that the client should start sending encrypted messages. At this point, the TLS handshake is complete. 

### What is a Cipher Suite?
A Cipher Suite is a set of crytographic algorithms that are used in the encryption/decryption and other related tasks. TLS users ciphers as part of establishing and maintaining a secure connection. Specifically, cipher suites are used in the key exchange process, as well as the authentication and verifying integrity of messages.

### What is encryption in the context of TLS?
In the context of TLS, encryption refers to the encoding of messages such that only authorised recipients can decode the message. Encryption/decryption in TLS is handled through the symmetric key generated through the TLS handshake process.

### What is symmetric key encryption? What is asymmetric key encryption? What's the difference?
Symmetric key encryption refers to the process where parties involved in message exchange encrypt their messages using the same key, such that only those parties can decrypt the messages. Secure information exchange is _multidirectional_.

Asymmetric key encryption is _unidirectional_; encrypted message exchange can only occur from one party to others, and not the other way around. A party in the message exchange has two keys; a public key, which is sent to the other party, and a private key, which is never shared. The sender encrypts a message using the public key, while only the recipient is able to decrypt the messages using the private key.

### What is authentication in the context of TLS? *
Authentication in in the context of TLS is verifying that a party in the message exchange is who they say they are. TLS provides this function through the use of _certificates_ and the _asymmetric key exchange_ process. 

Authentication is achieved in the TLS handshake through asymmetric key encryption through certificates:
1. As part of the `ServerHelloDone` message, the server will send a certificate, which includes the server's public key, a _signature_ (which is some data encrypted using the server's private key) and an original unencrypted version of that data.
2. When the client receives this message, it uses the public key in the certificate to decrypt the signature. If the decrypted signature matches the original version of that data, then it's highly likely that the server is who they say they are, since it is unlikely that an unauthorised party would have access to the private key.

### What is a certificate? *
A certificate is the identifier for a party who holds it. During the TLS handshake process, the receiver of the message will return a certificate as part of the `ServerHelloDone` message. As well as containing the public key used for asymmetric key encryption, the certificate itself is issued by a Certificate Authority (CA). The issue of that cerificate by the CA:
1. Verifies that the end-user is who they say they are (the method of validating this differs, but can require proof of domain ownership)
2. Digitally signs the certificate being issued. This is usually done by including a 'signature', which is some data that's been encrypted using the CA's private key, but also the original, unencrypted data. By using the public key to decrypt the signature and comparing it to the original data, a match indicates the certificate was in fact issued by the CA.

Certificates typically include the issuer's name and signature, and are typically signed by one intermediate CA, whose certificate is signed by a Root CA (whose certificate is self-signed, as the endpoint of the chain of trust).

### What is the chain of trust?
While certificates provide some measure of authentication in establishing a secure connection, there still exists the possibility that a party might fake their certificate.

The chain of trust is one mechanism that can be used to reduce this risk. An end user will typically be issued a single certificate by an intermediate certificate authority (CA). That intermediate CA will also be issued a certificate from a Root CA, typically a different party. 

This ensures there are multiple levels of authentication between different parties, reducing the likelihood of a party faking a certificate, and protecting the root CA's private key. This also means that if an intermediate CA's private key is leaked, the root CA can revoke the intermediate CA's certificate and issue a new one, which has the effect of invalidating all other certificates down the chain. 

This is still not a perfect solution, as the system still relies on an element of trust, since the Root CA's certificate is self-signed.

### What is integrity in the context of TLS? *
Integrity ensures that a messsage has not been faked or altered during the message exchange process. The way that TLS achieves this is through a `MAC` header (Message Authentication Code) in the TLS record. 

Integrity checks might take the following form:
1. As a message is sent, the sender creates a 'digest'; a piece of data from the original message being sent, generated using the hashing algorithm and pre-agreed hash value established during the TLS handshake, when the Cipher Suite was agreed. This is the value that's provided in the `MAC` header.
2. The message itself is then encrypted with the symmetric key, and sent to the recipient.
3. The recipient decrypts the message with the symmetric key. The recipient will then attempt to create the same digest using the pre-agreed hashing algorithm and hash value. If the digest does not match, then this indicates the message has been changed during the exchange process.
