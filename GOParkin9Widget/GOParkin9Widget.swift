//
//  GOParkin9Widget.swift
//  GOParkin9Widget
//
//  Created by Rico Tandrio on 04/05/25.
//

import WidgetKit
import SwiftUI
import SwiftData

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
    
    var parkingRecord: ParkingRecord?
    
    var body: some View {
        if parkingRecord != nil {
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    Image(systemName: "clock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                    
                    Text("\(parkingRecord?.createdAt.formatted(date: .omitted, time: .shortened) ?? "N/A")")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("GOP9")
                        .font(.system(size: 18))
                        .foregroundColor(.primary)
                        .fontWeight(.bold)
                    
                    Text("\(parkingRecord?.floor ?? "N/A")")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 5)
                
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
                .shadow(color: Color.black.opacity(0.25), radius: 20, x: 0, y: 4)
                
                Spacer()
                    .frame(height: 15)
                
            }
        } else {
            VStack(alignment: .center) {
                
                Spacer()
                
                Image(systemName: "parkingsign.radiowaves.left.and.right.slash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding(.bottom, 2)
                
                
                Text("Add one to track your parking.")
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 5)
                
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10, height: 10)

                        Text("Add Record")
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                }
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 3)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.25), radius: 20, x: 0, y: 4)
                
                Spacer()
                    .frame(height: 15)
                
            }
        }
    }
}

struct GOParkin9WidgetEntryMediumView: View {
    var entry: Provider.Entry
    
    var parkingRecord: ParkingRecord?
    
    var body: some View {
        if parkingRecord != nil {
            ZStack {
                
                if parkingRecord!.images.isEmpty {
                    Image("Image")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                        .overlay(Color.black.opacity(0.5))
                } else {
                    Image(uiImage: parkingRecord!.images[0].getImage())
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                        .overlay(Color.black.opacity(0.5))
                }
                
                HStack(alignment: .center) {
                    
                    VStack(alignment: .leading) {
                        
                        HStack {
                            Image(systemName: "clock")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 15, height: 15)
                            
                            Text("\(parkingRecord?.createdAt.formatted(date: .omitted, time: .shortened) ?? "N/A")")
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
                            
                            Text("\(parkingRecord?.floor ?? "N/A")")
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
                                    .foregroundStyle(.white)
                                    .frame(width: 20, height: 20)
                                
                                Text("Navigate")
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                        }
                        .frame(width: UIScreen.main.bounds.width / 2.5)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.25), radius: 20, x: 0, y: 4)
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            HStack {
                                Image(systemName: "car")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.white)
                                    .frame(width: 20, height: 20)
                                
                                Text("Complete")
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                        }
                        .frame(width: UIScreen.main.bounds.width / 2.5)
                        .background(Color.green)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.25), radius: 20, x: 0, y: 4)
                    }
                }
                .padding()
                .frame(width: 329, height: 155)
            }
        } else {
            
            VStack(alignment: .leading) {
                
                Text("No Active Parking Yet")
                    .font(.system(size: 18))
                    .foregroundColor(.primary)
                    .fontWeight(.semibold)
                
                Text("Add one to track your parking.")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .fontWeight(.medium)
                
                Spacer()
                
                
                    
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .frame(width: 14, height: 14)

                        Text("Add Record")
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                }
                .background(Color.blue)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.25), radius: 20, x: 0, y: 4)
                
            }
            .padding()
            .frame(width: 329, height: 155, alignment: .leading)
        }
    }
}

struct GOParkin9WidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    
    @Query(filter: #Predicate<ParkingRecord>{p in p.isHistory == false}) var parkingRecords: [ParkingRecord]

    var firstParkingRecord: ParkingRecord? {
        parkingRecords.first
    }

    var body: some View {
        switch family {
        case .systemSmall:
            GOParkin9WidgetEntrySmallView(entry: entry, parkingRecord: firstParkingRecord ?? nil)
        case .systemMedium:
            GOParkin9WidgetEntryMediumView(entry: entry, parkingRecord: firstParkingRecord ?? nil)
        default:
            GOParkin9WidgetEntryMediumView(entry: entry, parkingRecord: firstParkingRecord ?? nil)
        }
    }
}

struct GOParkin9Widget: Widget {
    let kind: String = "GOParkin9Widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            GOParkin9WidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
                .modelContainer(for: [ParkingRecord.self])
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
}

#Preview(as: .systemMedium) {
    GOParkin9Widget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
}
