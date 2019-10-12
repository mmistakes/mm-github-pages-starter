---
title:  "AspNet Core WebApp behind Kong Gateway (or any other proxy)"
date:   2019-10-12
categories:
  - aspnetcore
tags:
  - C#
  - aspnetcore
  - kong
  - application gateway
---
Recently our team faced a problem, where we developed an AspNetCore Web Application running in a docker container. The application was running fine when running container locally exposed on a host port, no surprise here :). The problem was when we hosted the application on aws where our setup is that all applications are hosted behind [Kong](https://konghq.com/kong/), home page was loading fine but js and css files were not being loaded and returning 404. Kong probably is not the best tool for this but our team does a lot of REST based services and this is the only servie with some internal UI so it does not make sense to use a different reverse proxy just for this application.  

Our kong setup is such that applications are exposed on paths and those paths are stripped before passing on to the relevant serivce. My initial suspicion was that becuase of striping the urls in the response are not being properly referenced and further requests to kong are failing.  

I must admit it was my first interaction/experience of using Kong and as our team is not responsible for managing kong we have limited exposure to how kong works. This means 1 thing, an opportunity to learn to set up kong see it in action, reproduce the issue and finally fix the problem.  

## Initial Setup
I started with creating a new GitHub repository to host all the related code. Then I created a new AspNet 2.2 Web App named DemoWebApp. For reference it was Add -> Add New Project -> .Net Core -> Web Application (Model-View Controller) in Visual Studio for Mac.  

## Kong Setup
Next step was to get kong up and running and setup service and route to mimic aws infrastructure. A quick google search and I came across an excellent [gist](https://gist.github.com/pantsel/73d949774bd8e917bfd3d9745d71febf) from [Panagis Tselentis](https://github.com/pantsel) which helped a great deal to get kong up and running with postgres and konga.  

Next step was to add docker-compose.yml and docker-compose.override.yml files next to DemoWebApp.sln, open Terminal and execute following to get all containers up  
```
docker-compose up
```
Or you can use following to run all services in background  
```
docker-compose up -d
```

From another terminal tab/window, use `docker ps` to see if postgres, kong, konga and demowebapp containers are running, in case kong failed to start earlier, you can use following to start kong or any other service, add service name as defined in docker-compose/docker-compose.override file.  
```
docker-compose up kong
```

Our app is available at `http://localhost:5000`, navigate to that in a browser and it would show the following, nothing fancy as done by the new project.  
<figure>
  <a href="/assets/images/2019-10-12/001.png"><img src="/assets/images/2019-10-12/001.png"></a>
  <figcaption>Home page accessed directly from docker.</figcaption>
</figure>

Next is setting up kong using konga. Navigate to `http://localhost:1337`, it would navigate to register screen, register a user as displayed below.  
<figure>
  <a href="/assets/images/2019-10-12/002.png"><img src="/assets/images/2019-10-12/002.png"></a>
  <figcaption>Register Konga Admin</figcaption>
</figure>

On the next page setup connection to Kong Admin.  
<figure>
  <a href="/assets/images/2019-10-12/003.png"><img src="/assets/images/2019-10-12/003.png"></a>
  <figcaption>Setup Connection to Kong Admin</figcaption>
</figure>

Navigate to <strong>Services</strong> from the left side menu and setup a service with values as displayed below, port would default to 80 and we will use this instead of 5000 because kong can access demowebapp container on docker's internal network.  
<figure>
  <a href="/assets/images/2019-10-12/004.png"><img src="/assets/images/2019-10-12/004.png"></a>
  <figcaption>Setup Service</figcaption>
</figure>

Next click on your newly created service name, select Routes and click `ADD ROUTE` button to setup a service as in screenshot below, important bits are `Paths`, `Methods` and `Strip Path`.  
<figure>
  <a href="/assets/images/2019-10-12/005.png"><img src="/assets/images/2019-10-12/005.png"></a>
  <figcaption>Setup Route</figcaption>
</figure>

Now that our service and route is setup in kong, lets use kong proxy to visit our application. Open new tab/window of browser and navigate to `http://localhost:8000/demowebapp`. It looks fine but navigating to `Privacy` results in an error, also if you open network tab of Chrome Developer Tools we can see css and js file errors.  
<figure>
  <a href="/assets/images/2019-10-12/006.png"><img src="/assets/images/2019-10-12/006.png"></a>
  <figcaption>Navigate to service using Kong</figcaption>
</figure>

## Solution
Now the solution to 404 for loading css/js and other resouces that are using relative paths. Another google search lead me to [Configure ASP.NET Core to work with proxy servers and load balancers](https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/proxy-load-balancer?view=aspnetcore-2.2) and the solution was to add following piece of code in Startup.cs.  

```
app.Use((context, next) =>
{
    context.Request.PathBase = new PathString("/demowebapp");
    return next();
});
```
And then execute following command to rebuild demowebapp and start it again    
```
docker-compose up -d --no-deps --build demowebapp
```

Refresh the application page `http://localhost:8000/demowebapp` and viola everything is loaded.
<figure>
  <a href="/assets/images/2019-10-12/007.png"><img src="/assets/images/2019-10-12/007.png"></a>
  <figcaption>Navigate to service using Kong</figcaption>
</figure>

Next I added following condition in middleware to only use `PathBase` if `X-Fowarded-For` header is set, you might want to check for other header values e.g. `X-Forwarded-Host`, `X-Forwarded-Proto`, `X-Forwarded-Server`, `X-Forwarded-Path`. This is required so that the application can access the relative paths regardless of if its running behind a reverse proxy or not i.e. load correctly in debug mode, accessed directly from demowebapp docker image or navigated from reverse proxy, in this case using kong.

## Source
Source code for the demo application, and docker-compose files are hosted on GitHub in [aspnetcore-behind-kong](https://github.com/kashifsoofi/aspnetcore-behind-kong) repository.  

## References
In no particular order  
[https://en.wikipedia.org/wiki/Advanced_Encryption_Standard](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard)
[Konga]https://github.com/pantsel/konga)
[docker-compose.yml for kong, postgres and konga](https://gist.github.com/pantsel/73d949774bd8e917bfd3d9745d71febf)
[Google](https://www.google.com)
[How to Update a Single Running docker-compose Container](https://staxmanade.com/2016/09/how-to-update-a-single-running-docker-compose-container/)
And many more