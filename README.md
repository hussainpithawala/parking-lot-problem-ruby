# Parking Lot Command Line Utility
This parking lot command line utility accepts a file as an argument and processes the contents of the file 
(basically on a line by line basis). Each line is basically a command to be executed with certain parameters.
Right now there are four commands which could be accepted.

1. **create_parking_lot** {capacity}    
    This command creates a parking lot with the capacity of slots provided as a parameter. It accepts integer as the parameter
2. **park** {reg_number}
    This command parks a vehicle in any of the nearest slot available from the entrance.
3. **leave** {reg_number} {hours}
    This command vacates a vehicle from parking lot and computes the parking fee for number of hours provided.
4. **status**
   This command doesn't needs any parameter and prints the status of the parked vehicles.

## Structure of the application
The application is designed by implementing **Command design pattern**. The four possible command's translate into different
command classes which have a common base class. These classes are
1. Command::BaseCommand
2. Command::Status
3. Command::Create
4. Command::Park
5. Command::Leave 

In order to read input file and process it's contents line by line
following classes are used. 

1. Processor::CommandProcessor
2. Processor::CommandFactory

A CommandProcessor is initialised through a script which takes a file-name as an argument. The CommandProcessor's process
method take a line of the file as an argument and processes it. It in turn breaks it up into commands and parameters and 
then delegates the task of building the command to CommandFactory's make method. CommandFactory's make method takes the 
command_key, parameters and current_context as the arguments. Any command works over a context and holds the reference 
to it. Once the command is executed we get the message as output. This forms our output. Also, after executing the 
command from it the context is fetched so that this represent the current state of the system.

The idea behind encapsulating all model classes and parameters in a context is to separate state from behaviour. A 
**Context** essentially represents the current state of the system. Any command that needs to mutate the state has to
create a new context and then returns the new context to the CommandProcessor. The CommandProcessor retains this
context so that current context forms the basis for the next command execution.  

The model classes are fairly simple to understand. I am listing those over here
1. Vehicle (base class for any type of vehicle)
2. Car (sub class of vehicle)
3. Slot (A place to park a vehicle)
4. Parking Lot (A place with many slots)
5. Context (A class to hold the reference to the ParkingLot and any parameters, which are passed for the execution of a
command)

## How to setup ?

First, install [Ruby](https://www.ruby-lang.org/en/documentation/installation/). Then run the following commands under the main dir.

```
parking_lot_2.0.0 $ ruby -v # confirm Ruby present
ruby 2.6.4p104 (2019-08-28 revision 67798) [x86_64-darwin18]
parking_lot_2.0.0 $ gem install bundler # install bundler to manage dependencies
Successfully installed bundler-2.0.2
Parsing documentation for bundler-2.0.2
Done installing documentation for bundler after 2 seconds
1 gem installed
parking_lot_2.0.0 $ bundle install # install dependencies
Using bundler 2.0.2
Using coderay 1.1.2
Using diff-lcs 1.3
Using method_source 0.9.2
Using pry 0.12.2
Using rspec-support 3.7.1
Using rspec-core 3.7.1
Using rspec-expectations 3.7.0
Using rspec-mocks 3.7.0
Using rspec 3.7.0
Bundle complete! 3 Gemfile dependencies, 10 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
functional_spec $ 
```

## How to run the test(s)

You can run the full suite from `parking_lot_2.0.0` by doing
```
parking_lot $ rspec 
...........................

Finished in 0.01671 seconds (files took 0.4255 seconds to load)
27 examples, 0 failures

```
## How to run the application
You can run the application using `bin/parking_lot` by doing
```
parking_lot/functional_spec $ ./bin/parking_lot functional_spec/fixtures/file_input.txt
```

## Author
* Hussain Pithawala (hussainpithawala@gmail.com)