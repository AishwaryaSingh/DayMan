
$(document).ready(function() 
{
    // page is now ready, initialize the calendar...
    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();
    var t = date.getTime();

    $('#date_range').hide();
    $('#schedule_change').hide();

    $('#calendar').fullCalendar({

 		events: function(start, end, timezone, callback)
        {
            $.ajax({
                url: '/users/', //'/users/:id',
                dataType : 'json',
                success: function(data)
                {
                	var events = [];
                    $.each( data , function(index, event)
                    {
   	                	event = {};  
   	                	var d = data[index];
                        event.id = d['id'];
                        event.title = d['name'];    
                        event.start = d['starttime']; 
                        event.end = d['endtime'];
                        event.allDay = false;                   
	                    events.push(event);
                    });

                    callback(events);
                },
                error: function(xhr, status, error)
                {
                    var err = eval("(" + xhr.responseText + ")");
                    alert(err.Message);
                }      
            });
        },

        //Header initialization
        header: 
        {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },

        defaulEventEnd: 60,
        eventLimit: true,
        defaultView: "agendaWeek",
        selectable: true,
        selectHelper: true,
        editable: false,
        height: 650,
        timeFormat: "h:mm ",
        dragOpacity: "0.5",
                
        views: {
            eventLimit: 1
        },

        slotDuration: '00:15:00',
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
            var view_now = $('#calendar').fullCalendar('getView');
            if(view_now.name == "month")
            {
                $('#calendar').fullCalendar('gotoDate', date);
                $('#calendar').fullCalendar('changeView', 'agendaWeek');
            }
            if(view_now.name == "agendaWeek")
            {
                $('#calendar').fullCalendar('gotoDate', date);
                $('#calendar').fullCalendar('changeView', 'agendaDay');
            }
        }

    });
});