//
//  GOParkin9Widget.swift
//  GOParkin9Widget
//
//  Created by Rico Tandrio on 04/05/25.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct GOParkin9WidgetEntrySmallView: View {
    var entry: Provider.Entry
    
    let condition = false
    
    var body: some View {
        if condition {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "clock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                    
                    Text("13:00")
                        .font(.system(size: 12))
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("GOP9")
                        .font(.system(size: 18))
                        .foregroundColor(.primary)
                        .fontWeight(.medium)
                    
                    Text("Basement 1")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
                
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "figure.walk")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                        
                        Text("Navigate")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }
                }
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 3)
                .background(Color.blue)
                .cornerRadius(10)
                
            }
        } else {
            VStack(alignment: .center) {
                
                Spacer()
                
                Image(systemName: "parkingsign.radiowaves.left.and.right.slash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                Spacer()
                
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10, height: 10)
                        
                        Text("Add Record")
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                    }
                }
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 3)
                .background(Color.blue)
                .cornerRadius(10)
                
            }
        }
    }
}

struct GOParkin9WidgetEntryMediumView: View {
    var entry: Provider.Entry
    
    let condition = true
    
    var body: some View {
        if condition {
            ZStack {
                
                Image("Image")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                    .overlay(Color.black.opacity(0.5))
                
                HStack(alignment: .center) {
                    
                    VStack(alignment: .leading) {
                        
                        HStack {
                            Image(systemName: "clock")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 15, height: 15)
                            
                            Text("13:00")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                                .fontWeight(.medium)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("GOP9")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                            
                            Text("Basement 1")
                                .font(.system(size: 12))
                                .opacity(0.8)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 5)
                    .padding(.vertical, 8)
                    
                    Spacer()
                    
                    VStack {
                        
                        Button {
                            
                        } label: {
                            HStack {
                                Image(systemName: "figure.walk")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                
                                Text("Navigate")
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(width: 130, height: 50)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 3)
                        .background(Color.blue)
                        .cornerRadius(10)
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            HStack {
                                Image(systemName: "car")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                
                                Text("Complete")
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(width: 130, height: 50)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 3)
                        .background(Color.green)
                        .cornerRadius(10)
                    }
                }
                .padding()
                .frame(width: 329, height: 155)
            }
        } else {
            HStack(alignment: .center) {
                
                VStack(alignment: .leading) {
                    
                    Spacer()
                    
                    Text("No Record")
                        .font(.system(size: 18))
                        .foregroundColor(.primary)
                        .fontWeight(.medium)
                    
                    Text("Try adding a new record")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                    
                }
                .padding(.horizontal, 5)
                .padding(.vertical, 8)
                
                Spacer()

                Button {
                    
                } label: {
                    VStack {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                        
                        Spacer()
                            .frame(height: 15)
                        
                        Text("Add Record")
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                }
                .frame(maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 3)
                .background(Color.blue)
                .cornerRadius(10)
            }
        }
    }
}

struct GOParkin9WidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        switch family {
        case .systemSmall:
            GOParkin9WidgetEntrySmallView(entry: entry)
        case .systemMedium:
            GOParkin9WidgetEntryMediumView(entry: entry)
        default:
            GOParkin9WidgetEntryMediumView(entry: entry)
        }
    }
}

struct GOParkin9Widget: Widget {
    let kind: String = "GOParkin9Widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            GOParkin9WidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .contentMarginsDisabled()
        .configurationDisplayName("GOParkin9 Widget")
        .description("Access your parking record quickly and easily.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemMedium) {
    GOParkin9Widget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
