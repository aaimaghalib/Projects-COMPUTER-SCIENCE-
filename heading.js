const testimonialText = document.querySelector('.heading h1');

const testimonials = [
    " Welcome to ToDoList App",
    " Task Management App",
    " Set Reminders for your daily Tasks"
];

let currentIndex = 0;

function changeTestimonial() {
    // First, remove the typing animation class to reset it
    testimonialText.style.animation = 'none'; 

    // Update the text after a short delay to give time for animation reset
    setTimeout(function() {
        // Change the text content
        testimonialText.textContent = testimonials[currentIndex];

        // Reapply the typing animation class to trigger it again
        testimonialText.style.animation = 'typing 2s steps(30, end), cursor 0.7s step-end infinite';
        
        // Move to the next testimonial
        currentIndex = (currentIndex + 1) % testimonials.length;
    }, 100); // Small delay to reset the animation
}

// Change testimonials every 3 seconds
setInterval(changeTestimonial, 3000);

// Trigger the initial testimonial change
changeTestimonial();