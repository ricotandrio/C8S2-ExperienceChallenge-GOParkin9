//
//  GOParkin9Widget.swift
//  GOParkin9Widget
//
//  Created by Rico Tandrio on 04/05/25.
//

import WidgetKit
import SwiftUI
import SwiftData

// MARK: - Widget Timeline Entry Model
struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let parkingRecord: ParkingRecord?
}

// MARK: - Widget Provider
struct Provider: AppIntentTimelineProvider {
    let sampleParkingRecord: ParkingRecord = .init(
        latitude: 0,
        longitude: 0,
        images: [],
        floor: "Basement 2"
    )
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), parkingRecord: sampleParkingRecord)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, parkingRecord: sampleParkingRecord)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        do {
            let modelContainer = try ModelContainer(for: ParkingRecord.self)

            let modelContext = ModelContext(modelContainer)

            let descriptor = FetchDescriptor<ParkingRecord>(
                predicate: #Predicate { $0.isHistory == false },
                sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
            )

            let parkingRecords = try modelContext.fetch(descriptor)
            let firstRecord = parkingRecords.first

            let entry = SimpleEntry(date: Date(), configuration: configuration, parkingRecord: firstRecord)

            entries.append(entry)

            return Timeline(entries: entries, policy: .atEnd)

        } catch {
            let entry = SimpleEntry(date: Date(), configuration: configuration, parkingRecord: nil)
            return Timeline(entries: [entry], policy: .atEnd)
        }
    }

}

// MARK: - Widget Views for Small
struct GOParkin9WidgetEntrySmallView: View {
    var entry: Provider.Entry
    
    var body: some View {
        if entry.parkingRecord != nil {
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    Image(systemName: "clock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                    
                    Text("\(entry.parkingRecord?.createdAt.formatted(date: .omitted, time: .shortened) ?? "N/A")")
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
                    
                    Text("\(entry.parkingRecord?.floor ?? "N/A")")
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
                .widgetURL(URL(string: AppLinks.viewCompassUrl))
                
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
                .widgetURL(URL(string: AppLinks.addRecordUrl))
                
                Spacer()
                    .frame(height: 15)
                
            }
        }
    }
}

// MARK: - Widget Views for Medium
struct GOParkin9WidgetEntryMediumView: View {
    var entry: Provider.Entry
    
    var body: some View {
        if entry.parkingRecord != nil {
            ZStack {
                
                if entry.parkingRecord!.images.isEmpty {
                    Image("Image")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                        .overlay(Color.black.opacity(0.5))
                } else {
                    if let originalImage = entry.parkingRecord?.images.first?.getImage(),
                       let resizedImage = originalImage.resized(to: CGSize(width: 150, height: 150)) {
                        
                        Image(uiImage: resizedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipped()
                            .overlay(Color.black.opacity(0.5))
                    }
                }
                
                HStack(alignment: .center) {
                    
                    VStack(alignment: .leading) {
                        
                        HStack {
                            Image(systemName: "clock")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 15, height: 15)
                            
                            Text("\(entry.parkingRecord?.createdAt.formatted(date: .omitted, time: .shortened) ?? "N/A")")
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
                            
                            Text("\(entry.parkingRecord?.floor ?? "N/A")")
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
                        Link(destination: URL(string: AppLinks.viewCompassUrl)!) {
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
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.vertical, 20)
                        .frame(width: UIScreen.main.bounds.width / 2.5)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.25), radius: 20, x: 0, y: 4)
                        
                        Spacer()
                        
                        Link(destination: URL(string: AppLinks.completeRecordUrl)!) {
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
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.vertical, 20)
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
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                }
                .background(Color.blue)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.25), radius: 20, x: 0, y: 4)
                .widgetURL(URL(string: AppLinks.addRecordUrl))
                
            }
            .padding()
            .frame(width: 329, height: 155, alignment: .leading)
        }
    }
}

// MARK: - Widget Views for Inline at Lock Screen
struct GOParkin9WidgetEntryInlineView: View {
    var entry: Provider.Entry
    
    var body: some View {
        if entry.parkingRecord != nil {
            HStack {
                Text("GOP9 at \(entry.parkingRecord?.floor ?? "N/A")")
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 5)
            }
        } else {
            HStack {
                Text("No Active Parking Yet.")
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 5)
            }
        }
    }
}

// MARK: - Widget Views for Circular at Lock Screen
struct GOParkin9WidgetEntryCircularView: View {
    var entry: Provider.Entry
    
    var body: some View {
        if entry.parkingRecord != nil {
            Image(systemName: "parkingsign.radiowaves.left.and.right")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding(.bottom, 2)
                .padding()
        } else {
            Image(systemName: "parkingsign.radiowaves.left.and.right.slash")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding(.bottom, 2)
        }
    }
}

// MARK: - Widget Views for Rectangular at Lock Screen
struct GOParkin9WidgetRectangleView: View {
    var entry: Provider.Entry

    var body: some View {
        if entry.parkingRecord != nil {
            HStack {
                Text("GOP9 at \(entry.parkingRecord?.floor ?? "N/A")")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 5)
            }
        } else {
            HStack {
                Text("No Active Parking Yet")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 5)
            }
        }
    }
}

// MARK: - Widget Entry View
struct GOParkin9WidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        switch family {
        case .systemSmall:
            GOParkin9WidgetEntrySmallView(entry: entry)
        case .systemMedium:
            GOParkin9WidgetEntryMediumView(entry: entry)
        case .accessoryInline:
            GOParkin9WidgetEntryInlineView(entry: entry)
        case .accessoryRectangular:
            GOParkin9WidgetRectangleView(entry: entry)
        default:
            GOParkin9WidgetEntryCircularView(entry: entry)
        }
    }
}

// MARK: - Widget Configuration
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
        .supportedFamilies([
            .accessoryInline,
            .accessoryCircular,
            .accessoryRectangular,
            .systemSmall,
            .systemMedium
        ])
    }
}

// MARK: - Preview
extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
}

#Preview(as: .accessoryRectangular) {
    GOParkin9Widget()
} timeline: {
    SimpleEntry(
        date: .now,
        configuration: .smiley,
        parkingRecord: .init(
            latitude: 0,
            longitude: 0,
            images: [],
            floor: "Basement 2"
        )
    )
}
