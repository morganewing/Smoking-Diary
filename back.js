module.exports = function(context, callback) {

   //newuser : save in the temp and put temp to data for storage
   //olduser : change the info directly to the data from get, doesn not even need to set 

   username = context.data.username

   var s = context.data.date
   context.data.date = new Date(s)

   var isnewuser = true
   var ctxnewuser = {}
   // var numcig_exist = false

   //  ctxnewuser[username] = {
   //  date : undefined,
   //  NumCig : undefined,
   //  Activity: undefined,
   //  Location: undefined,
   //  people : undefined,
   //  mood : undefined
   // }


   // >>>>> for testing: put some to data
   // var input = {}
   // input = {
   //  usename: "abc",
   //  date : "june 29, 2017", 
   //  numcig : 1 ,
   //  activity: ["programming", "work"],
   //  location : "quit genius",
   //  people : "coworker",
   //  mood : "happy"
    // entries: [{
    //             usename: "abc",
    //             date : "june 29, 2017", 
    //             NumCig : 1 ,
    //             Activity: ["programming", "work"],
    //             Location : "quit genius",
    //             people : "coworker",
    //             mood : "happy"
    //            }]
   // }
   // var input1 = {}
   // input1 = {
   //     username : "adfjakj",
   //     date : "june 29, 2017", 
   //     NumCig : 3 ,
   //     Activity: ["programming", "work"],
   //     Location : "quit genius",
   //     people : "coworker",
   //     mood : "happy"
   // }
       // entries: { {
 //                username : "jae",
       //          date : "june 29, 2017", 
       //          NumCig : 1 ,
       //          Activity: ["programming", "work"],
       //          Location : "quit genius",
       //          people : "coworker",
       //          mood : "happy"
 //               }, 
 //               {
 //                username : "jae",
       //          date : "june 29, 2017", 
       //          NumCig : 2 ,
       //          Activity: ["programming", "work"],
       //          Location : "quit genius",
       //          people : "coworker",
       //          mood : "happy"
 //               }
       //  }

   // // // >>>>>> for testing: data to put
   //     context.data = {
   //             username : "jae" ,
   //             date : "june 29, 2017", 
   //             numcig : 97 ,
   //             activity: ["programming", "work"],
   //             location : "quit genius",
   //             people : "coworker",
   //             mood : "happy"
   //         }

   // username = context.data.username

   // var s = context.data.date
   //     context.data.date = new Date(s)


   context.storage.get(function(error, data) {
       data = data || []
       // data.push(input)
       // data.push(input1)        
       // username = context.data.username

       if (data.length != 0) {
           for (var i = 0; i < data.length; i++) { 
               if (data[i].username == username) {
                   isnewuser = false
                   var index = i
                   }
           }
       } 





   //console.log(context.data.date)

   //>>>>input format checking
   if (context.data.date.getDate() != NaN && context.data.date.getFullYear() >= 2017) {
       if (isnewuser) {
           ctxnewuser.date = context.data.date
       } else {
           data[index].date = context.data.date
       }
   } else {
       return callback(new Error("please put valid date ex. january, 01, 2017", 400))
   }

   //to save cumulated cig of olduser
   // console.log(context.data.numCig)
   if (typeof context.data.numcig == 'number') {
       if (isnewuser) {
       ctxnewuser.numcig = context.data.numcig
       } else {
           // console.log(data[index].NumCig)
           // console.log(context.data.NumCig)
           data[index].numcig += context.data.numcig
           // data[index].NumCig += context.data.NumCig
           // var saveNumCig = data[index].NumCig
           // console.log("saveNumCig:" + saveNumCig)
       }
   } else {
       // return callback(new Error("please put valid number of cigarettes ex. 1", 400))
       return callback(new Error("please put valid number of cigarettes ex. 2", 400))
   }

   //Activity = ["working", "studying" ...]
   if (typeof context.data.activity == 'object') {
       for (var i = 0; i < context.data.activity.length; i ++) {
           var act = context.data.activity[i]
           if (typeof act != 'string') {
               return callback(new Error(activity + "is not a valid activity"), 400)
           }
       }
       if (isnewuser) {
           ctxnewuser.activity = context.data.activity
       } else {
           data[index].activity = context.data.activity
       }
   } else {
       return callback(new Error("please put valid list of Activity ex. [using quit genius app, ...]", 400))
   }


   if (typeof context.data.location == 'string') {
       if (isnewuser) {
       ctxnewuser.location = context.data.location
       } else {
           data[index].location = context.data.location
       }
   } else {
       return callback(new Error("please put valid Location ex. home", 400))
   }


   if (typeof context.data.people == 'string') {
       if (isnewuser) {
       ctxnewuser.people = context.data.people
       } else {
           data[index].people = context.data.people
       }
   } else {
       return callback(new Error("please put valid people ex. family", 400))
   }


   if (typeof context.data.mood == 'string') {
       if (isnewuser) {
       ctxnewuser.mood = context.data.mood
       } else {
           data[index].mood = context.data.mood
       }
   } else {
       return callback(new Error("please put valid mood ex. happy", 400))
   }

   // console.log(ctxnewuser)

       //entries :saving all the data the user put so far
       if (isnewuser) {
           //ctxnewuser.NumCig : cumulated number of cigs
           //context.data.NumCig: number of cigs of input
           var temp = {}
           var entry = {
                username: username,
                date: ctxnewuser.date ,
                numcig: ctxnewuser.numcig ,
                activity: ctxnewuser.activity ,
                location: ctxnewuser.location ,
                people: ctxnewuser.people ,
                mood: ctxnewuser.mood
               }

           temp = {
               username: username,
               date: ctxnewuser.date ,
               numcig: ctxnewuser.numcig ,
               activity: ctxnewuser.activity ,
               location: ctxnewuser.location ,
               people: ctxnewuser.people ,
               mood: ctxnewuser.mood,
               entries: [entry]
           }

           data.push(temp)

           context.storage.set(data, function(error) {

           // console.log(data)
       })
           callback(null, temp)

       } else {
           // callback(null, temp)
       // } else {
           // console.log("making entries for old user")
           // console.log(data[index])
           // console.log("before entries:" + data[index])

           var ent = {
               username: username,
               date: data[index].date ,
               numcig: context.data.numcig ,
               activity: data[index].activity ,
               location: data[index].location ,
               people: data[index].people ,
               mood: data[index].mood
               }

           // curr.entries = []
           data[index].entries.push(ent)


           context.storage.set(data, function(error) {

           // console.log(data)
       })
       callback(null, data[index])
   }

})
}