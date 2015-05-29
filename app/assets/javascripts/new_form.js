
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
              throw new Error(this.name+" is null! please fill in all details.");
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
    var batch_id = $("#batch_id").val();
    var branch_id = $("#branch_id").val();
    var semester_id = $("#semester_id").val();

    // page is now ready, initialize the calendar...
    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();
    var t = date.getTime();

    $('#date_range').hide();

    // Fullcalendar..
    $('#calendar').fullCalendar({

        events: function(start, end, timezone, callback)
        {
            $.ajax({
                url : '/schedules/new',
                dataType: 'json',
                data : {'batch_id' : batch_id , 'branch_id' : branch_id , 'semester_id' : semester_id },

                success : function(data)
                {
                    schedule = data['schedules'];
                    var events = [];
                    $.each( schedule , function(index, event)
                    {
                        event = {};  
                        var d = schedule[index];
                        event.id = d['id'];
                        event.title = "Lecture"
                        event.description = d['name'];    
                        event.start = d['starttime']; 
                        event.end = d['endtime'];
                        event.allDay = false;       
                        event.subjectId = d['subject_id'];   
                        event.roomId = d['room_id'];   
                        event.userId = d['user_id'];  
                        event.subjectId = d['batch_ids[]'];    
                        event.imageURL = "/images/close1.png "       
                        events.push(event);
                    });
                    callback(events);
                },
                error : function(error)
                {
                    alert("An error occured while fetching events!!");
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

       // theme: true,
        eventLimit: true,
        selectable: true,
        selectOverlap: false,
        slotEventOverlap:false,
        eventOverlap: false,
        slotDuration: '00:15:00',                        
        defaulEventEnd: 60,
        defaultView: "agendaWeek",
        selectable: true,
        selectHelper: true,
        editable: true,
        height: 650,
        timeFormat: "h:mm ",
        dragOpacity: "0.5",
        editable: true,
        durationEditable: true,
        
        views: {
            eventLimit: 1
        },

        titleFormat: 
        {
            month: 'MMMM YYYY',    
        },
        columnFormat:
        {
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
            element.find('.fc-time', this ).append("<img src='http://desxcloud.com/daniel/img/delete-icon.gif' width='15px' height='15px' id='close'/>");
            element.find('.fc-title').append("<br/>" + event.description);
            element.find('#close', this).hide();
        },

        eventClick: function(event, jsEvent, view)
        {
            $("#startTime").text(event.start.format(" HH:mm DD-MM-YYYY"));
            $("#endTime").text(event.end.format(" HH:mm DD-MM-YYYY"));
               
            $("#schedule_create").hide();
            $("#schedule_update").show();

            $("#dialog").data("event-id",event.id);

            $("#schedule_subject_id").val(event.subjectId);
            $("#schedule_room_id").val(event.roomId);
            $("#schedule_user_id").val(event.userId);
            console.log($("#dialog").dialog("open"));
        },

        eventMouseover: function( event, jsEvent, view)
        {
            
            $('#close', this).show();
       //   event.addClass("animated shake");
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
                data : {'batch_id' : batch_id , 'branch_id' : branch_id , 'semester_id' : semester_id },
                dataType: 'json'
            });

            $("#startTime").text(start.format(" HH:mm DD-MM-YYYY"));
            $("#endTime").text(end.format(" HH:mm DD-MM-YYYY"));
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

            success : function(schedule) {},
            error : function(error)
            {
                alert("An error occured while updating events! Please try again!");
                revertFunc();
            }
        });
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
        formObject["schedule[branch_id]"] = $("#branch_id").val();
        formObject["schedule[semester_id]"] = $("#semester_id").val();
        formObject["schedule[batch_id]"] = $("#batch_id").val();
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
    });

    $("#date_range_check").click(function(event)
    {
        alert("In date_range_check");
        $("date_range").show();
    });

    //On updating rails form
    $("#schedule_update").click(function(event)
    {    
        var event_id = $("#dialog").data("event-id");
        event.preventDefault();
        var formObject = $('#new_schedule').serializeObject();      
        formObject["schedule[branch_id]"] = $("#branch_id").val();
        formObject["schedule[semester_id]"] = $("#semester_id").val();
        formObject["schedule[batch_id]"] = $("#batch_id").val();
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
    });

    $("span#apply").on("click",function(event)
    {    
        alert("apllied!");
        var batch_id = $("#batch_id").val();
        var branch_id = $("#branch_id").val();
        var semester_id = $("#semester_id").val();
        $.ajax({
            url:"/schedules/initialize_subjects",
            type: "POST",
            data : {'batch_id' : batch_id , 'branch_id' : branch_id , 'semester_id' : semester_id },
            dataType: 'json'
        });
        $("#calendar").fullCalendar('refetchEvents');
    });
});
