---
title: "How to use Jetty build simple Http Server"
date: 2019-08-29T00:00:00-04:00
categories:
  - Java
tags:
  - Jetty
---
Hello guys. I will explain how to use Jetty to build HTTP server in this blog. Welcome to leave comments if you have any trouble about it.

# Precondition

the reader should download Jetty before the start. According to the official document, the reader can download Jetty at the download page, and access API document



# Build HTTP Jetty server
The first step, create a server instance
```java
Server server = new Server(8081);
```
Create a basic jetty server object that will listen on port 8081. Note that if you set this to port 0 then a randomly available port will be assigned that you can either look in the logs for the port or programmatically obtain it for use in test cases.



The second step, need to set Handler which should be wrapped.
```java
server.setHandler(handler);
```
the handler is an instance of an interface implementation class of `org.eclipse.jetty.server.Handler` interface. A Handler instance is required by an `org.eclipse.jetty.server.Server` to handle incoming HTTP requests.

Handlers are passed the servlet API request and response object but are not Servlets. The servlet container is implemented by handlers for context, security, session, and servlet that modify the request object before passing it to the next stage of handling.

`org.eclipse.jetty.server.Handler` interface has lots of derived class, this chapter will demonstrate `ServletContextHandler` usage.


`handler` made a relevance with `Servlet` Instance by call function `handler.addServlet()`.
```java
  ServletContextHandler handler = new ServletContextHandler(
  	ServletContextHandler.SESSIONS|ServletContextHandler.NO_SECURITY);
  handler.setContextPath("/hello");
  ServletHolder myserverletholder = new ServerletHolder(new myserverlet());
  handler.addServlet(myserverletholder, pathSpec);
```
`myservletholder` is an instance of `org.eclipse.jetty.servlet.ServletHolder`. it's Servlet Instance and Context Holder. Holds the name, params and some state of a `javax.servlet.Servlet` instance. It implements the `ServletConfig` interface. This class will organize the loading of the servlet when needed or requested.



Each ServletHolder instance normally interests a `javax.servlet.Servlet` interface, it's a small Java program that runs within a Web server. Servlets receive and respond to requests from Web clients, usually across HTTP, the HyperText Transfer Protocol. To implement this interface,  you can write an HTTP servlet that extends `javax.servlet.http.HttpServlet`.


```java
    public static class myservlet extends HttpServlet {
        /**
         * handle get request
         */
        @Override
        protected void doGet(HttpServletRequest request,
                HttpServletResponse response) throws ServletException,
                IOException {
        //somecode
        }
        /**
         * handle post request
         */
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp)
          throws ServletException, IOException {
         //somecode
        }
```

The last step, need to start the server
```java
server.start();
```
We have discussed the ServletContextHandler usage, actually `org.eclipse.jetty.server.Handler` interface has lots of derived class. my GitHub also demonstrated [WebAppContext][WebAppContext] demo.

# Epilogue
Above demonstrated how to create a simple HTTP server use Jetty, I hope this page will be helpful for you. if you have any troubles or thoughts, welcome to leave a message. Have a good day!

[WebAppContext]: https://github.com/voltWu/Jetty-HTTP-example