$("#add_planet_to_flight_plan").submit(function(e){
    // Stop the form submitting
    e.preventDefault();
    console.log("Heeeeeelp")
    console.log(e)
    e.currentTarget.submit();
});
