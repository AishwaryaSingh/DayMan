$(document).ready(function() 
{
    // page is now ready, initialize the calendar...
    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();
    var t = date.getTime();

    $(".data").hide();


    $('#calendar').fullCalendar({

        events: [
        {
            title: "",
        }
        ],


        events: function(start, end, timezone, callback) {
        
            
        },

        //Header initialization


        header: 
        {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },

        slotMinutes: 15,                        //NOT WORKING!
        defaulEventEnd: 60,
        defaultView: "agendaWeek",
        selectable: true,
        selectHelper: true,
        editable: true,
        height: 500,
     //   events: "/dashboard/get_events",
        timeFormat: "h:mm ",
        dragOpacity: "0.5",

        titleFormat: 
        {
            month: 'MMMM YYYY',    
        },
        columnFormat: {
            week: 'ddd, DD/MM ',
            day: 'dddd'
        },

        dayClick: function(date, allDay, jsEvent, view)
        {    
            $('#calendar').fullCalendar('gotoDate', date);
            $('#calendar').fullCalendar('changeView', 'agendaDay');            
        },

        select: function(start, end, allDay)
        {
            $("#calendar").hide();
            $(".data").show();
            var starttime = start;
            console.log('yes')
            
            $("button").on("click",function()
            {
                //How to save time ?
                $(".data").hide(); 
                $("#calendar").show();
            });        
            calendar.fullCalendar('unselect');                
        }
    });


});
