    $(function()
    {
        $("#dialog").dialog({
            autoOpen: false,
            width: 570,
            modal: true
        });
        $( "#menu" ).menu({
            disabled: true
        });
    });
var global=false;
    jQuery.fn.serializeObject = function()
    {
        var arrayData, objectData;
        arrayData = this.serializeArray();
        objectData = {};
        $.each(arrayData, function(index)
        {
            var value = arrayData[index];
            if (this.value != '')
            {
              value = this.value;
            } 
            else 
            {
                global=true;
              alert(this.name+" is null! please fill in all details.");
            }
            if (objectData[this.name] != null) 
            {            
             if (!objectData[this.name].push) 
              {
                objectData[this.name] = [objectData[this.name]];
              }
              objectData[this.name].push(value);
            } 
            else 
            {
              objectData[this.name] = value;
            }
        });
        return objectData;
    };


$(document).ready(function() 
{
    // page is now ready, initialize the calendar...
    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();
    var t = date.getTime();

    $('#user_id').hide();
    $('#schedule_change').hide();

    $('#calendar').fullCalendar({

 		events: function(start, end, timezone, callback)
        {
            $.ajax({
                url: '/users/', 
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
                        event.start_date = d['start_date']; 
                        event.end_date = d['end_date'];
                        event.period = d['period']; 
                        event.subjectId = d['subject_id'];   
                        event.roomId = d['room_id'];   
                        event.userId = d['user_id'];  
                        event.subjectId = d['batch_ids[]'];    
                        event.imageURL = "/images/close1.png "                   
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
        hiddenDays:[0],
        defaulEventEnd: 60,
        eventOverlap: true,
        eventLimit: true,
        defaultView: "agendaWeek",
        selectable: true,
        selectHelper: true,
        editable: true,
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
        },

        eventDrop: function( event, delta, revertFunc, jsEvent, ui, view )
        {
            updateEvents(event, revertFunc);
        },

        eventResize: function( event, delta, revertFunc, jsEvent, ui, view )
        {
            updateEvents(event,revertFunc);
        },

        eventRender: function(event, element)
        {    
            element.find('.fc-time', this ).append("<img src='http://icons.iconarchive.com/icons/visualpharm/must-have/256/Delete-icon.png' width='15px' height='15px' id='close'/>");
            element.find('#close', this).hide();
        },

        eventClick: function(event, jsEvent, view)
        {
            $("#startTime").text(event.start.format(" HH:mm DD-MM-YYYY"));
            $("#endTime").text(event.end.format(" HH:mm DD-MM-YYYY"));
               
            $("#schedule_create").hide();
            $("#schedule_update").show();
            
            $("#schedule_start_date_1i").val(event.start.format("YYYY"));
            $("#schedule_start_date_2i").val(parseInt(event.start.format("MM")));
            $("#schedule_start_date_3i").val(parseInt(event.start.format("DD")));

            $("#schedule_end_date_1i").val(event.end.format("YYYY"));
            $("#schedule_end_date_2i").val(parseInt(event.end.format("MM")));
            $("#schedule_end_date_3i").val(parseInt(event.end.format("DD")));

            $("#dialog").data("event-id",event.id);

            $("#schedule_subject_id").val(event.subjectId);
            $("#schedule_room_id").val(event.roomId);
            $("#schedule_user_id").val(event.userId);
            console.log($("#dialog").dialog("open"));
        },

        eventMouseover: function( event, jsEvent, view)
        {
            
            $('#close', this).show();
            i = 0;
            $("#close", this).on("click" , function()
            {
                if(i == 0)
                {
                    delete_event(event.id);
                    i = 1;
                }
                else
                {
                    i = 33333333333;
                }
            });
        },
        eventMouseout: function( event, jsEvent, view )
        {
            $('#close', this).hide();
        },

        select: function(start, end, allDay)
        {
            var example = $("#startTime").val();
            $.ajax({
                url:"/schedules/new",
                type: "GET",
                dataType: 'json'
            });
            $("#startTime").text(start.format(" HH:mm DD-MM-YYYY"));
            $("#endTime").text(end.format(" HH:mm DD-MM-YYYY"));
            
            $("#schedule_start_date_1i").val(start.format("YYYY"));
            $("#schedule_start_date_2i").val(parseInt(start.format("MM")));
            $("#schedule_start_date_3i").val(parseInt(start.format("DD")));

            $("#schedule_end_date_1i").val(end.format("YYYY"));
            $("#schedule_end_date_2i").val(parseInt(end.format("MM")));
            $("#schedule_end_date_3i").val(parseInt(end.format("DD")));

            $("#schedule_create").show();
            $("#schedule_update").hide();
            $("#dialog").dialog("open");            
        }
    });

    //Delete
    var  delete_event = function(event)
    {
        var r = confirm("Are you sure you want to delete?");
        var event_id = event;
        if (r)
        {
            $.ajax({
                url: '/schedules/'+event_id,
                type: 'DELETE',
                dataType: "json",
                data : { id : $("span#close").data("event_id") },
                success : function(response)
                {
                    $('#calendar').fullCalendar('removeEvents',response.id);
                    $('#dialog').dialog("close");
                },
                error : function(error)
                {
                    alert("Could not Delete. Try again.");
                }
            });
        }
        $('#schedule_change').show();
    };

    //To update the datbase with new values on Resize or DragDrop
    var  updateEvents = function(event , revertFunc )
    {    
        var jobj = JSON.parse(JSON.stringify(event));
        $.ajax({
            url:"/schedules/"+event.id,
            type: "PATCH",
            data : { "schedule[id]" : event.id, "schedule[name]" : jobj.title, "schedule[starttime]" : jobj.start, "schedule[endtime]" : jobj.end },
            dataType: "json",

            success : function(schedule) {

            },
            error : function(error)
            {
                alert("An error occured while updating events! Please try again!");
                revertFunc();
            }
        });
        $('#schedule_change').show();
    };

    //To check atleast one checkbox is selected
    var checkboxBatch = function()
    {
       var atLeastOneIsChecked = $('input:checked').length > 0;
       if(atLeastOneIsChecked) { return true; }
       else { alert("Select atleast one checkbox!"); return false; }        
    };

    //On submiting rails form
    $("#schedule_create").click(function(event)
    {    
        event.preventDefault();
        var formObject = $('#new_schedule').serializeObject();
        formObject["schedule[starttime]"] = $("#startTime").text();
        formObject["schedule[endtime]"] = $("#endTime").text();
        formObject["schedule[user_id"] = $("#user_id").text();

        var arr = []; 
        $.each($("input:checked"), function()
        {
          arr.push($(this).val());
        });

        formObject["schedule[batch_id]"] = arr;
        var jObject = JSON.stringify(formObject);
        var jsonObject = JSON.parse(jObject);   
        if($("#branch_id").val() == "" || $("#semester_id").val() == "" || $("#batch_id").val()=="")
        {
            if(global==false)
            {
                alert("Enter All the Details!");
            }     
        }
        else
        {
        var t =checkboxBatch();
        if (t)
        {
            $.ajax({
                url : '/schedules',
                type: 'POST',
                data : jsonObject,
                dataType: 'json' ,

                success : function(response)
                {
                    $("#dialog").dialog("close");
                    $('#calendar').fullCalendar('refetchEvents');
                },    
                error : function(error)
                {
                   alert("An error occured while creating! Please try again!");
                }
            });
        }
        $('#schedule_change').show();
    }
    });

    //On updating rails form
    $("#schedule_update").click(function(event)
    {    
        var event_id = $("#dialog").data("event-id");
        event.preventDefault();
        var formObject = $('#new_schedule').serializeObject();  
        formObject["schedule[starttime]"] = $("#startTime").text();
        formObject["schedule[endtime]"] = $("#endTime").text();

        var arr = []; 
        $.each($("input:checked"), function()
        {
          arr.push($(this).val());
        });
        
        formObject["schedule[batch_id]"] = arr;
        var jObject = JSON.stringify(formObject);
        var jsonObject = JSON.parse(jObject);

        var t =checkboxBatch();
        if (t)
        {
            $.ajax({
               url:"/schedules/"+event_id,
                type: "PUT",
                data : jsonObject , 
                dataType: 'json' ,
                
                success : function(response)
                {
                    $("#dialog").dialog("close");
                    $('#calendar').fullCalendar('refetchEvents');
                },    
                error : function(error)
                {
                   alert("An error occured! Please try again!");
                }
            });
        }
        $('#schedule_change').show();
    });

    $("#schedule_change").click(function(event)
    { 
        
    });
});