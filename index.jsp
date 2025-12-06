<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShopEasy - Your Online Store</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f8f9fa;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1rem 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 1.8rem;
            font-weight: bold;
        }

        .nav-links {
            display: flex;
            list-style: none;
            gap: 2rem;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            transition: opacity 0.3s;
            padding: 0.5rem 1rem;
        }

        .nav-links a:hover {
            opacity: 0.8;
            background: rgba(255,255,255,0.1);
            border-radius: 4px;
        }

        .hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 4rem 0;
            text-align: center;
        }

        .hero h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        .hero p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
        }

        .btn {
            padding: 1rem 2rem;
            background: white;
            color: #667eea;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1.1rem;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
            transition: transform 0.2s ease;
        }

        .btn:hover {
            transform: scale(1.05);
        }

        .features {
            padding: 4rem 0;
        }

        .features h2 {
            text-align: center;
            font-size: 2.5rem;
            margin-bottom: 3rem;
            color: #2c3e50;
        }

        .feature-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
        }

        .feature-card {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }

        .feature-card:hover {
            transform: translateY(-5px);
        }

        .feature-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        .feature-card h3 {
            color: #667eea;
            margin-bottom: 1rem;
        }

        footer {
            background: #2c3e50;
            color: white;
            text-align: center;
            padding: 2rem 0;
            margin-top: 2rem;
        }

        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2rem;
            }
            
            .nav-links {
                gap: 1rem;
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <header>
        <nav class="container">
            <div class="logo">🛍️ ShopEasy</div>
            <ul class="nav-links">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="products.jsp">Products</a></li>
                <li><a href="customers.jsp">Customers</a></li>
                <li><a href="orders.jsp">Orders</a></li>
                <li><a href="contact.jsp">Contact</a></li>
            </ul>
        </nav>
    </header>

    <section class="hero">
        <div class="container">
            <h1>Welcome to ShopEasy</h1>
            <p>Your One-Stop Online Shopping Destination</p>
            <a href="products.jsp" class="btn">Shop Now</a>
        </div>
    </section>

    <section class="features">
        <div class="container">
            <h2>Why Choose Us?</h2>
            <div class="feature-grid">
                <div class="feature-card">
                    <div class="feature-icon">✅</div>
                    <h3>Quality Products</h3>
                    <p>High-quality products at competitive prices</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🚚</div>
                    <h3>Fast Shipping</h3>
                    <p>Fast and reliable delivery to your door</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">💳</div>
                    <h3>Secure Payments</h3>
                    <p>Safe and secure payment processing</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🔄</div>
                    <h3>Easy Returns</h3>
                    <p>Hassle-free returns and exchanges</p>
                </div>
            </div>
        </div>
    </section>

    <footer>
        <div class="container">
            <p>&copy; 2025 ShopEasy. All rights reserved.</p>
            <p>📧 support@shopeasy.com | 📞 +1 (555) 123-4567</p>
        </div>
    </footer>
</body>
</html>