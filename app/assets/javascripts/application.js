// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.js
//= require fullcalendar
//= require bootstrap

$(document).ready(function() 
{
    // page is now ready, initialize the calendar...
    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();
    var t = date.getTime();

    $('#calendar').fullCalendar({


        events: function(start, end, timezone, callback) {
            alert("In events function()");

        $.ajax({

            url: '/schedule.json',//'/users/:id',
            dataType : 'json',
          //  dd: {"start" : start , "end" : end},

            success: function(doc)
            {
                alert("In success function");
                var events = [];

               
              //  callback(events);
            //}

               events = doc.events;
                alert(events);

                callback(events);
            },
             error: function(xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert(err.Message);
            }
                  
        });
    },

       // allDayDefault : true,
       
        //Header initialization
        header: 
        {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },

        defaulEventEnd: 60,
        defaultView: "agendaWeek",
        selectable: true,
        selectHelper: true,
        editable: true,
        height: 500,
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

        slotMinutes: 15                        //NOT WORKING!
    });
});


function loadFullCalendarData(start,end)
{

    alert("In loading");
    $.ajax({
        
        type: "POST",
       // data: '{startDate: "' + $.fullCalendar.formatDate(start, 'M/d/yyyy')
       // + '",' + 'endDate: "' + $.fullCalendar.formatDate(end, 'M/d/yyyy') + '" }',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        url : '/schedule.json',
      
        success: function(dd)
        {
        
            var obj = jQuery.parseJSON(dd);
            /*var events = new Array();
            $.each( obj, function(index, event)
            {
                event = new Object();       
                event.start = value['starttime']; 
                event.end = value['endtime'];
                event.allDay = false;
                events.push(event);
           
                $('#calendar').fullCalendar('removeEvents');
                $('#calendar').fullCalendar('addEventSource', events);         
                $('#calendar').fullCalendar('rerenderEvents' );
           //     $('#calendar').fullCalendar('renderEvent', event);
                
            });*/


                $('#calendar').fullCalendar('removeEvents');
                $('#calendar').fullCalendar('addEventSource', obj);         
                $('#calendar').fullCalendar('rerenderEvents' );
           //     $('#calendar').fullCalendar('renderEvent', event);
        }
    });
}