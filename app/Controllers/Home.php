<?php

namespace App\Controllers;

class Home extends BaseController
{
    public function index(): string
    {
        return view('welcome_message');
    }

    public function about(): string
    {
        return view('about');
    }

    public function project(): string
    {
        return view('project');
    }

    public function experience(): string
    {
        return view('experience');
    }

    public function contact(): string
    {
        return view('contact');
    }
}
