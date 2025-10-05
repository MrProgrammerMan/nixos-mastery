use axum::{routing::get, Router};

#[tokio::main]
async fn main() {
    let app = Router::new().route("/", get(|| async { "This response was sent from Axum!" }));
    let listener =  tokio::net::TcpListener::bind("0.0.0.0:80").await.unwrap();
    axum::serve(listener, app).await.unwrap();
}