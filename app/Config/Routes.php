<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'Home::index');
$routes->get('/about', 'Home::about');
$routes->get('/project', 'Home::project');
$routes->get('/experience', 'Home::experience');
$routes->get('/contact', 'Home::contact');
