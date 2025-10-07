use axum::{routing::get, Router};
use std::env;
use std::net::SocketAddr;

#[tokio::main]
async fn main() {
    // Read the port from command line args, e.g. `--port=8080`
    let port = std::env::args()
        .find_map(|arg| {
            if let Some(value) = arg.strip_prefix("--port=") {
                value.parse::<u16>().ok()
            } else {
                None
            }
        })
        .unwrap_or(8080); // default port if not passed

    // Build the router
    let app = Router::new().route("/", get(|| async { "This response was sent from Axum!" }));

    // Bind to 0.0.0.0:<port>
    let addr = SocketAddr::from(([0, 0, 0, 0], port));
    println!("Listening on http://{}", addr);

    let listener = tokio::net::TcpListener::bind(addr).await.unwrap();
    axum::serve(listener, app).await.unwrap();
}