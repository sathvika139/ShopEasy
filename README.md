# ShopEasy — Java E-Commerce Web Application
This is **ShopEasy**, a simple e-commerce web application built with **Java Servlets, JSP, JDBC, XML configuration, and deployed on Apache Tomcat**.
It connects to a **MySQL database** to store order details and customer information.

## 🚀 Features
- View list of products available for purchase
- User can place orders through a form
- Orders are stored in **MySQL** database
- JSP pages used for UI
- Servlet controllers handle business logic
- Uses MVC-style structure (JSP + Servlets)

## 📂 Project Structure
ShopEasy/
│
├── WebContent/ # Web files (JSP pages + HTML + CSS)
│ ├── index.jsp
│ ├── products.jsp
│ ├── placeOrder.jsp
│ ├── orders.jsp
│ ├── customers.jsp
│ ├── contact.jsp
│ └── view_messages.jsp
│
├── WEB-INF/ # Deployment descriptor + web.xml
│ ├── web.xml
│ └── lib/
│
├── src/ # Java source files
│ └── com/shopeasy/util/
│ └── Database util classes
│
├── README.md
└── .gitignore


## 🛠️ Technologies Used

| Category              |                          Technology |
|-----------------------|-------------------------------------|
| Backend               |                       Java Servlets |
| Frontend              |             JSP (Java Server Pages) |
| Database              |                               MySQL |
| Web Server            |                       Apache Tomcat |
| Database Connectivity |                                JDBC |
| Build                 | Manual or Eclipse/IDE configuration |
