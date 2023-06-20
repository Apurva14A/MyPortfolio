from django.shortcuts import render, get_object_or_404
from .models import Blog
from django.utils import timezone

def all_blogs(request):
    blogs = Blog.objects.filter(published_date__lte=timezone.now()).order_by('-published_date')
    return render(request, 'blog/all_blogs.html', {'blogs':blogs})

def blog_detail(request, pk):
    blog = get_object_or_404(Blog, pk=pk)
    return render(request, 'blog/blog_detail.html', {'blog':blog})
