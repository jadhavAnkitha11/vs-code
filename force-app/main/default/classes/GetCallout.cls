public with sharing class GetCallout {
    public static HttpResponse getMessage() {
       Http http=new Http();
       HttpRequest request= new HttpRequest();
       request.setEndpoint('https://reqres.in/api/users');
       request.setMethod('GET');
       HttpResponse response=http.send(request);
       if(response.getStatusCode()==200){
        System.debug('response'+JSON.serialize(response.getBody()));
       }
       return response;
    }

    public static HttpResponse postMessage(){
        Http http=new Http();
        HttpRequest request=new HttpRequest();
        request.setEndpoint('https://reqres.in/api/register');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"email":"vasavi@gmail.com"}');
        HttpResponse response=http.send(request);
        if(response.getStatusCode()==400){
            System.debug(response.getBody());
           }
           return response;
        }
    
        public static HttpResponse putMessage(){
            Http http=new Http();
            HttpRequest request=new HttpRequest();
            request.setEndpoint('https://reqres.in/api/users/2');
            request.setMethod('PUT');
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            request.setBody('{"name":"vasu","job":"software"}');
            HttpResponse response=http.send(request);
            if(response.getStatusCode()==200){
                System.debug(response.getBody());
               }
               return response;
            }

            public static HttpResponse patchMessage(){
                Http http=new Http();
                HttpRequest request=new HttpRequest();
                request.setEndpoint('https://reqres.in/api/users/2');
                request.setMethod('PATCH');
                request.setHeader('Content-Type', 'application/json;charset=UTF-8');
                request.setBody('{"name":"vasu","job":"software"}');
                HttpResponse response=http.send(request);
                if(response.getStatusCode()==200){
                    System.debug(response.getBody());
                   }
                   return response;
                }

                public static HttpResponse deleteMessage(){
                    Http http=new Http();
                    HttpRequest request=new HttpRequest();
                    request.setEndpoint('https://reqres.in/api/users/2');
                    request.setMethod('DELETE');
                    request.setHeader('Content-Type', 'application/json;charset=UTF-8');
                    request.setBody('{"name":"vasu","job":"software"}');
                    HttpResponse response=http.send(request);
                    if(response.getStatusCode()==204){
                        System.debug(response.getBody());
                       }
                       return response;
                    }
    }
