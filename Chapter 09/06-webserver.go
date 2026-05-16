// main.go
package main

import (
	"fmt"
	"net/http"
	"os"
	"time"
)

// Create a fast handler
var handlerCommon = http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
	fmt.Println(r.Proto, r.RemoteAddr)
	fmt.Fprintf(w, "Hello from fast endpoint, Protocol: %s\n", r.Proto)
})

// Create a slow handler
var handlerCommonSlow = http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
	fmt.Println(r.Proto, r.RemoteAddr)
	time.Sleep(5 * time.Second)
	fmt.Fprintf(w, "Hello from slow endpoint, Protocol: %s\n", r.Proto)
})

func main() {
	mux := http.NewServeMux()
	mux.Handle("/", handlerCommon)
	mux.Handle("/slow", handlerCommonSlow)

	var err error
	if os.Args[1] == "http2" {
		fmt.Println("Starting HTTP/2 server on https://:8443")
		fmt.Println("Note: HTTP/2 requires TLS")

		// Start server with HTTP/2 support (enabled by default when using TLS)
		err = http.ListenAndServeTLS("0.0.0.0:8443", "cert.pem", "key.pem", mux)
	} else {
		fmt.Println("Starting HTTP server on http://:8080")
		err = http.ListenAndServe("0.0.0.0:8080", mux)
	}
	if err != nil {
		panic(err)
	}
}
