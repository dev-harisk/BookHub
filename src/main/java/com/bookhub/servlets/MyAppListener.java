package com.bookhub.servlets;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class MyAppListener implements ServletContextListener {
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		// Initialization code can go here
		System.out.println("Web application started.");
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		try {
			// Shutdown the abandoned connection cleanup thread
			com.mysql.cj.jdbc.AbandonedConnectionCleanupThread.checkedShutdown();
			System.out.println("Web application stopped and resources cleaned up.");
		} catch (Exception e) {
			Thread.currentThread().interrupt(); // Restore interrupted status
			System.err.println("Error during cleanup: " + e.getMessage());
		}
	}
}
