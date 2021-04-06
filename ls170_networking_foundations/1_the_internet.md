# The Internet

## Table of Contents
- [What is the Internet?](#what-is-the-internet)
- [Protocols](#protocols)
- [A Layered System](#a-layered-system)
- [Data Encapsulation](#data-encapsulation)
- [The Physical Network](#the-physical-network)

### What is the Internet?
We can think of the internet as a 'network of networks', the idea being that any network can communicate with any other network that is linked to it. A __network__, at it's most basic level, it's *two devices connected in such a way that they can communicate or exchange data*. A primitive implementation of this would be connecting two computers directly to each other using a LAN cable, and configuring their network settings in such a way that they form a distinct network.

Another example is the _local access network (LAN)_, such as in an office environment, where there are multiple computers and other devices connected via a _network bridging device_ such as a hub or, more likely, a switch. The computers are all connected to this device via network cables, and this forms the network. At home, you most likely have the same setup, except that the connections to the network bridging device are wireless, such that we have a _wireless local access network_ (WLAN).

The key thing to understand here is that the __scope of communications is limited to devices that are connected__ (either wired or wirelessly) to the network switch or hub, which imposes some geographic limitations. That's the 'local' in Local Area Network. In order to enable communication between networks, we need to add __routers__ into the picture. Routers are network devices that can _route network traffic to other networks_. Within a Local Area Network, they effectively act as __gateways__ into and out of the network.

![Inter-network communication](https://da77jsbdz4r05.cloudfront.net/images/ls170/what-is-internet-2-LANs-with-routers.png)

We can imagine the internet as a vast number of these networks connected together. In between all of the sub-networks are systems of routers that direct the network traffic.

![A network of networks](https://da77jsbdz4r05.cloudfront.net/images/ls170/what-is-internet-multiple-networks-routers.png)

### Protocols
There are countless different devices that can connect to the internet, ranging from laptops, tablets, and phones, to kettles, toasters, and lightbulbs. All of these devices connect via thousands of different makes and models of hubs, switches, and routers, to endless different configurations of servers. Added to this, these components will be running a massive variety of software.

In order to ensure that these disparate devices and operating systems are able to interface with each other, we need to use __protocols__. In simple terms, we can think of a protocol as a __system of rules__. In terms of computer networks, it's a __set of rules governing the exchange or transmission of data__. 

There are numerous different protocols that are used to communicate over the internet. A short list of some of the more widely used protocols might include the following:
- IP
- SMTP
- TCP
- HTTP
- Ethernet
- FTP
- DNS
- UDP
- TLS

Why there are so many different protocols for network communication? There are a number of different reasons for this. Two of the main ones are:
- Different protocols were developed to address different aspects of network communication.
- Different protocols were developed to address the same aspect of network communication, but in a different way or for a specific use-case.

#### 'Different aspects of network communication'
When we speak to someone else, we can perhaps think of a particular grouping of words as one message within an overall conversation. To ensure that a particular message is understood, we need to order the words within that message in a certain order. We can think of this word order as part of the _syntactical rules that govern the structure of the message_.

A different aspect of communication might be the *flow and order* of all the messages in the conversation. For example, speaking in turn rather than both at the same time. We can maybe think of these as *message transfer rules* for how speech is conducted.

#### 'The same aspect of network communication, but in a different way or for a specific use-case'
You can probably think of various situations where different sets of message transfer rules are or aren't appropriate.
  - If a student wants to ask the teacher a question in a classroom, we might have fairly strict rules for initiating and conducting the transfer of messages:
```
1. Student raises hand
2. Teacher acknowledges student
3. Student asks question
4. Teacher answers question
```
  - A different situation, with less strictly-defined rules, might be a social conversation between friends. All the participants are peers with no hierarchy. Anyone can initiate a message exchange and anyone can respond.
  - Yet another situation might be someone giving a presentation at a conference. The speaker might start speaking at a specific set time, and should normally be allowed to deliver the presentation without interruption while the audience listens.

All of these situations are concerned with the same aspect of communication, the flow and order of the message transfer, but use _different sets of rules or protocols_.

We can think of network communication protocols in the same way. __TCP__ and __UDP__ would be examples of two protocols that address the same _basic aspect_ of communication, the transfer of messages between applications, but do so in different ways. __TCP__ and __HTTP__ would be examples of two protocols that address _different aspects of communication_; TCP for the transfer of messages between applications, and HTTP for the structure of those messages.

### A Layered System
We looked at how different sets of rules, or _protocols_, address different aspects of communication. It can be useful to _group_ these protocols together in terms of the _particular aspect of communication that they address_. Furthermore, we can think of protocol groups as functioning within __layers__ of an overall system of communication. If we were to do that with our previous example of verbal human communication, with a couple of protocol group layers added, it might look something like this:

| Protocol Group | Purpose |
|-|-|
| Logical Message Structure |	Linguistic rules for how to structure a message, e.g. word order |
| Logical Message Transfer |	Etiquette rules for transfer of individual messages from one person to another, e.g. initiating conversation or turn to speak |
| Physical Message Creation/ Interpretation | The physics and biology of speech and hearing, e.g control of vocal chords and functioning of the ear |
| Physical Message Transfer |	Transfer of the message across the physical medium, e.g. sound waves carried through air |

The same idea can be applied to computer network communication, and there are numerous different models which attempt to do this. Two of the most popular are the [OSI model](https://en.wikipedia.org/wiki/OSI_model) and the [Internet Protocol Suite](https://en.wikipedia.org/wiki/Internet_protocol_suite) (also known as the TCP/IP model or DoD model). There is some rough equivalency, albeit with some overlap, between the layers of the two models.
- The top layer of the Internet Protocol Suite (Application) mostly maps to the top three layers of the OSI Model (Application, Presentation, Session).
- The second layer of the Internet Protocol Suite (Transport) mostly maps to the fourth layer of the OSI model (Transport)
- The third layer of the Internet Protocol Suite (Internet) mostly maps to the fifth layer of the OSI model (Network)
- The fourth layer of the Internet Protocol Suite (Link) mostly maps to the bottom two layers of the OSI model (Data Link and Physical)

![Image of different models](https://da77jsbdz4r05.cloudfront.net/images/ls170/layered-system-osi-tcp-ip-comparison.png)

The reason for the different number of layers between the two models is due to the difference in approach each model takes. The Internet Protocol Suite divides the layers in terms of the __scope of communications within each layer__ (within a local network, between networks, etc). The OSI model divides the layers in terms of the __functions that each layer provides__ (physical addressing, logical addressing and routing, encryption, compression, etc).

Although there is utility in both of these approaches, no single model will perfectly fit a real-world implementation. Such models are useful for gaining a broad-brush view of how a system works as a whole, and for modularizing different levels of responsibility within that system. 

### Data Encapsulation
One concept used by both models, and in fact by most network communication models, is the idea of __data encapsulation__. You will already have encountered the term encapsulation in the context of programming, where it means hiding the internal representation of an object and preventing it from being accessed from outside the object.

The idea is similar in network models. Here we are essentially __hiding data from one layer by encapsulating it within a data unit of the layer below__. 

#### Data Protocol Units
Within our network models, a __Protocol Data Unit (PDU)__ is an _amount or block of data transferred over a network_. Different protocols or protocol layers refer to PDUs by different names. At the Link/Data Link layer, for example, a PDU is known as a _frame_. At the Internet/Network layer it is known as a _packet_. At the Transport layer, it is known as a _segment_ (TCP) or _datagram_ (UDP).

In all cases, the basic concept is effectively the same; the PDU consists of a __header__, a __data payload__, and in some cases a __trailer or footer__.

![Protocol Data Unit](https://da77jsbdz4r05.cloudfront.net/images/ls170/layered-system-pdu.png)

#### Headers and Trailers
The exact structure of the header and, if included, trailer varies from protocol to protocol, but the purpose of them is the same in each case: to __provide protocol-specific metadata about the PDU__. For example, an Internet Protocol (IP) packet header would include fields for the Source IP Address and the Destination IP Address, which would be used to correctly route the packet.

#### Data Payload
The data payload portion of a PDU is simply the data that we want to transport over the network using a specific protocol at a particular network layer.

The data payload is the key to the way encapsulation is implemented. The entire PDU from a protocol at one layer is __set as the data payload for a protocol at the layer below__. For example, a HTTP Request at the Application layer could be set as the payload for a TCP segment at the transport layer.

![Data Encapsulation](https://da77jsbdz4r05.cloudfront.net/images/ls170/layered-system-encapsulation.png)

The major benefit of this approach is the _separation it creates between the protocols at different layers_. This means that a protocol at one layer doesn't need to know anything about how a protocol at another layer is implemented in order for those protocols to interact. This effectively creates a system whereby a _lower layer_ (the more granular protocol) effectively provides a 'service' to the layer _above_ it (the aggregated protocol).

A TCP segment isn't concerned whether its data payload is an HTTP request, an SMTP command, or some other sort of Application layer data. _It just knows it needs to encapsulate some data from the layer above and provide the result of this encapsulation to the layer below_.

This separation of layers provides a certain level of abstraction, which allows us to use different protocols at a certain layer without having to worry about the layers below. This is especially apparent at the Application layer, where many different protocols are used depending on the application and use case. For example, an email client would use SMTP, and web browser HTTP, and a file transfer program FTP, but all three of these programs could use TCP at the Transport layer to transfer the application layer data.

### The Physical Network
Underlying all our talk of data encapsulation and protocols is a __'physical' network__ made of tangible pieces such as networked devices, cables, and wires. Even the radio waves used in wireless networks, though we can't touch or see them, exist in the physical realm and are bound by physical laws and rules.

These __laws and rules determine how data gets transported__ from one place to another in a physical sense. What happens at this level involves real-world limitations and boundaries, such as how fast an electrical signal or light can travel, or the distance a radio wave can reach. These limitations determine the physical characteristics of a network, and these characteristics have an impact on how protocols function further up at the conceptual level. If we want to work with these protocols, it is therefore important to have at least a basic understanding of how a network works at this level.

#### Bits and Signals
The OSI model defines a Physical layer as the bottommost layer of its model (Layer 1). The Internet Protocol Suite doesn't really concern itself directly with physical interfaces, though it does include some physical functions in the Link layer. 

Either way, the functionality at this level is essentially concerned with the transfer of bits (binary data). In order to be transported, these bits are converted into signals. Depending on the transportation medium used, bits are converted to electrical signals (copper wire, which conducts electricity), light signals (fibre optic cables), or radio waves.

#### Characteristics of a physical network
The two main characteristics in terms of the performance of a physical network are __Latency__ and __Bandwidth__. In simple terms, latency is a _measure of the time it takes for some data to get from one point in a network to another point in a network_. Bandwidth is the __amount__ of data that can be sent in a _particular unit of time_ (typically, a second).

In respect of latency and bandwidth, we can think of an analogy of cars travelling at a constant speed on a road. If we increase the number of lanes on a road, we increase the bandwidth (more information), but latency __does not__ increase - the cars are still travelling at the same speed. Just increasing the bandwidth __doesn't necessarily improve the performance of a network__. 

#### Elements of Latency
We can think of latency as a _measure of delay_. Data starts at one location at a certain point in time. At a later point in time, it reaches another location. The difference between those two points in time is the delay. There are different types of delay that go together to determine the overall latency of a network connection.
