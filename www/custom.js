$(document).ready(function() {
    // Example: Change background color of the "Explore Data" button when hovered over
    $("#load").hover(
        function() {
            $(this).css("background-color", "#007bff");
        }, 
        function() {
            $(this).css("background-color", "");
        }
    );

    // Example: Show an alert when a user uploads a CSV file in "Clean Data" page
    $("#file1").on("change", function() {
        alert("You have uploaded a CSV file for data cleaning!");
    });

    // Example: Automatically scroll down to the table when data is loaded
    $("#load").on("click", function() {
        $('html, body').animate({
            scrollTop: $("#data").offset().top
        }, 1000);
    });

    // Example: Add tooltips to inputs
    $("#dataset").attr("title", "Select a dataset to explore");
    $("#load").attr("title", "Click to load the dataset");
    $("#plot_var").attr("title", "Choose a variable to plot");

    // Example: Confirmation pop-up when submitting a solution in the "Post Solutions" tab
    $("#submit_solution").on("click", function() {
        let userConfirmed = confirm("Are you sure you want to submit your solution?");
        if (!userConfirmed) {
            return false; // Stop form submission if user cancels
        }
    });
});
