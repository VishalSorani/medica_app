

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:medica_app/app/views/managedoctors/managedoctors_controller.dart';

class DoctorForm extends StatelessWidget {
  const DoctorForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagedoctorController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Add Doctor Details'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Profile Image
                Center(
                  child: GestureDetector(
                    onTap: controller.pickImage,
                    child: Obx(() => Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                            image: controller.profileImagePath.value != null
                                ? DecorationImage(
                                    image: AssetImage(
                                        controller.profileImagePath.value!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: controller.profileImagePath.value == null
                              ? const Icon(Icons.add_a_photo,
                                  size: 50, color: Colors.grey)
                              : null,
                        )),
                  ),
                ),
                const SizedBox(height: 24),

                // Doctor Name
                TextFormField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    labelText: 'Doctor Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter doctor name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Doctor Details
                TextFormField(
                  controller: controller.detailsController,
                  decoration: const InputDecoration(
                    labelText: 'Doctor Details',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter doctor details';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Doctor Payment
                TextFormField(
                  controller: controller.paymentController,
                  decoration: const InputDecoration(
                    labelText: 'Payment (\$)',
                    border: OutlineInputBorder(),
                    prefixText: '\$ ',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter payment amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Doctor Rating
                GetBuilder<ManagedoctorController>(
                    id: ManagedoctorController.ratingId,
                    builder: (controller) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Doctor Rating',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const SizedBox(width: 16),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderThemeData(
                                    trackHeight: 2.0,
                                    activeTrackColor: Colors.blue,
                                    inactiveTrackColor: Colors.grey[300],
                                    thumbColor: Colors.blue,
                                    overlayColor: Colors.blue.withOpacity(0.2),
                                    valueIndicatorColor: Colors.blue,
                                    tickMarkShape:
                                        const RoundSliderTickMarkShape(
                                            tickMarkRadius: 0.0),
                                    inactiveTickMarkColor: Colors.grey,
                                    activeTickMarkColor: Colors.blue,
                                    // Use LineSliderTickMarkShape for more visible ticks
                                    showValueIndicator:
                                        ShowValueIndicator.always,
                                  ),
                                  child: Slider(
                                    value: controller.rating.toDouble(),
                                    min: 1,
                                    max: 5,
                                    divisions: 4,
                                    label: controller.rating.toString(),
                                    onChanged: controller.updateRating,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                const SizedBox(height: 16),

                // Doctor Specialization Dropdown
                GetBuilder<ManagedoctorController>(
                    id: ManagedoctorController.specializationId,
                    builder: (controller) {
                      return DropdownButtonFormField<String>(
                        value: controller.selectedSpecialization.isEmpty
                            ? null
                            : controller.selectedSpecialization,
                        decoration: const InputDecoration(
                          labelText: 'Specialization',
                          border: OutlineInputBorder(),
                        ),
                        items: controller.specializationOptions
                            .map(
                              (specialization) => DropdownMenuItem(
                                value: specialization,
                                child: Text(specialization),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.updateSpecialization(value);
                          }
                        },
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please select specialization'
                            : null,
                      );
                    }),

                const SizedBox(height: 16),

                // Doctor Start Time & End Time
                GetBuilder<ManagedoctorController>(
                  builder: (controller) => Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          decoration: const InputDecoration(
                            labelText: 'Start Time (Hour)',
                            border: OutlineInputBorder(),
                          ),
                          value: controller.startTime,
                          items: controller.hours.map((int hour) {
                            return DropdownMenuItem<int>(
                              value: hour,
                              child: Text('$hour:00'),
                            );
                          }).toList(),
                          onChanged: controller.updateStartTime,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          decoration: const InputDecoration(
                            labelText: 'End Time (Hour)',
                            border: OutlineInputBorder(),
                          ),
                          value: controller.endTime,
                          items: controller.hours.map((int hour) {
                            return DropdownMenuItem<int>(
                              value: hour,
                              child: Text('$hour:00'),
                            );
                          }).toList(),
                          onChanged: controller.updateEndTime,
                          validator: controller.validateEndTime,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Available Days (Multiple Selection)
                GetBuilder<ManagedoctorController>(
                  builder: (controller) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Available Days',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: controller.daysOfWeek.map((day) {
                          final isSelected = controller.isDaySelected(day);
                          return FilterChip(
                            label: Text(day),
                            selected: isSelected,
                            onSelected: (selected) =>
                                controller.toggleDay(day, selected),
                            selectedColor: Colors.blue[100],
                            checkmarkColor: Colors.blue,
                          );
                        }).toList(),
                      ),
                      controller.selectedDays.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Please select at least one day',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                    ),
                    onPressed: () => controller.submitForm(context),
                    child: const Text('Save Doctor Information'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

// Category class to handle the ID and name relationship
// class Category {
//   final String id;
//   final String name;

//   Category({required this.id, required this.name});
// }
