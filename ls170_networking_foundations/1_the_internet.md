# The Internet

## Table of Contents
- [What is the Internet?](#what-is-the-internet)
- [Protocols](#protocols)
- [A Layered System](#a-layered-system)

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
We can think of protocol groups as functioning within __layers__ of an overall system of communication. If we were to do that with our previous example of verbal human communication, with a couple of protocol group layers added, it might look something like this:

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
